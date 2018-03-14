From: bhsharma@redhat.com (Bhupesh Sharma)
Date: Wed, 14 Mar 2018 10:33:03 +0530
Subject: [Query] ARM64 kaslr support - randomness, seeding and kdump
In-Reply-To: <20180314021050.GK25863@linaro.org>
References: <CACi5LpMhHt4bjEueOzHZTGpzuR2zoQqXcReL-khoSNLG6=FVmg@mail.gmail.com>
 <CAKv+Gu8qd=rpJkG_GoVO=kkmc4qx_zZD8c_wwE16gr=8wSShSw@mail.gmail.com>
 <20180313102158.GI25863@linaro.org>
 <20180313104715.prurmrizho4ddc4l@lakrids.cambridge.arm.com>
 <20180313110747.GJ25863@linaro.org>
 <20180313112016.ocx4qqhji3zfwjhs@lakrids.cambridge.arm.com>
 <CACi5LpN4DTYFVSVqru2j0y=CKr2ztrJ1gCW32sJBU=oUV2fcWw@mail.gmail.com>
 <20180314021050.GK25863@linaro.org>
Message-ID: <CACi5LpPUKEWYfVDFvrfnf4_2LgKbKat-meMTzTXWEPN_D8nAVQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

'

On Wed, Mar 14, 2018 at 7:40 AM, AKASHI Takahiro
<takahiro.akashi@linaro.org> wrote:
> On Wed, Mar 14, 2018 at 01:18:47AM +0530, Bhupesh Sharma wrote:
>> On Tue, Mar 13, 2018 at 4:50 PM, Mark Rutland <mark.rutland@arm.com> wrote:
>> > On Tue, Mar 13, 2018 at 08:07:49PM +0900, AKASHI Takahiro wrote:
>> >> On Tue, Mar 13, 2018 at 10:47:15AM +0000, Mark Rutland wrote:
>> >> > On Tue, Mar 13, 2018 at 07:22:03PM +0900, AKASHI Takahiro wrote:
>> >> > > On Mon, Mar 12, 2018 at 08:58:00PM +0000, Ard Biesheuvel wrote:
>> >> > > > On 12 March 2018 at 20:14, Bhupesh Sharma <bhsharma@redhat.com> wrote:
>> >> >
>> >> > > More importantly, neither arm64 _kexec_ supports kaslr.
>>
>> Sorry if my earlier email was not clear on this, but I meant both the
>> kdump/kexec cases.
>>
>> While for kdump there is no current requirement for physical
>> randomization, for kexec it would be good to support the same as the
>> primary kernel was already supporting kaslr and the secondary kernel
>> (if compiled with CONFIG_RANDOMIZE_BASE) would randomizes the virtual
>> address at which the kernel image is loaded.
>>
>> If we have physical randomization supported in this case in the
>> secondary/kexec kernel we can avoid potential misuse related to the
>> physical address being known at which the secondary/kexec kernel is
>> loaded.
>>
>> >> >
>> >> > The below is just considering this, and ignoring kdump (where I don't
>> >> > think we care at all about KASLR).
>> >> >
>> >> > > Currently kexec-tools is set to determine where the kernel actually be
>> >> > > loaded, using a constant offset, text_offset, which comes from an image's
>> >> > > boot header and relocation of an image to the load address is performed
>> >> > > at the very end of the first kernel without knowing whether the 2nd kernel
>> >> > > has kaslr support enabled or not.
>> >> >
>> >> > The kexec tools shouldn't need to know whether the kernel supports KASLR
>> >> > at all.
>> >> >
>> >> > If the new kernel image has bit 3 (Kernel physical placement) set, kexec
>> >> > tools can choose to randomize the physical load address, regardless of
>> >> > whether that kernel has KASLR enabled.
>> >>
>> >> So, by definition, is randomness, if we say so, in physical address not
>> >> part of KASLR?
>> >
>> > Physical randomization is not part of the kernel's KASLR implementation.
>> >
>> > We happen to do it in the EFI stub, because we can in that context. But
>> > generally, physical randomization is not part of arm64's in-kernel
>> > KASLR.
>> >
>> > For various reasons, the physical address that the kernel is loaded to
>> > may be arbitrary, so we have to cope with physical randomization
>> > regardless.
>>
>> Indeed, since the primary kernel depends on the  firmware's
>> EFI_RNG_PROTOCOL implementation (if available) to randomise the
>> physical location of the kernel Image, for the secondary/kexec kernel,
>> if can have two approaches to enable physical randomization:
>
> I believe that you're now talking about "virtual" randomization.
>
>> - Implement a UEFI stub for loading the kexec kernel as well, or
>>
>> - Extend the 'kexec-tools' to invoke the entropy source available in
>> the primary kernel (provided by the firmware via EFI_RNG_PROTOCOL)  to
>> generate a random seed to randomize the physical address and populate
>> it in the '/chosen/kaslr-seed' property of the device-tree being
>> passed to the secondary/kexec kernel and let the normal code flow in
>> ' arch/arm64/kernel/kaslr.c', function 'kaslr_early_init' to get the
>> seed for the secondary kernel from the '/chosen/kaslr-seed' property
>> itself.
>>
>> Personally the later approach looks simpler to me from a implementation p-o-v.
>
> If kaslr-seed has a critical value in terms of security, is kexec-tools
> a right place? It is exposed to user space albeit for a short time of period.

But doesn't this problem exist in the arm64 kexec design already for
kexec_load() case?
Since it relies on sending a dtb (updated with the
'linux,usable-memory') property to the secondary/kexec kernel, we can
easily introduce a security vulnerability in the system by expanding
the dtb to include a static value for '/chosen/kaslr-seed'.

Consider the following scenario (which I tried yesterday on my arm64
board just out of curiosity):

1. Primary kernel and secondary kernel both are compiled with kaslr
flags (CONFIG_RANDOMIZE_BASE)

2. Primary kernel is loaded at random physical address on the basis of
the '/chosen/kaslr-seed' property.

3. Thereafter this property is memset to 0.

4. Now we call 'kexec -l + kexec -e' combination to warm boot to a
secondary/kexec kernel.

5. Since 'kexec-tools' picks up the existing dtb with
'/chosen/kaslr-seed' set to 0, it passes the same to the
secondary/kexec kernel.

6. Instead if we have a vulnerable 'kexec-tools' user space
application, which unpacks the dtb and sets the '/chosen/kaslr-seed'
to a known static non-zero value.

7. Now the secondary/kexec kernel is invoked and the
'kaslr_early_init()' finds a valid, non-zero '/chosen/kaslr-seed' and
uses it to calculate the offsets for randomizing the linear region and
randomizing the base of the module region. Since the seed was a known
static value, determining the randomized bases of the above regions is
always possible.

So, I am not sure the existing 'kexec-tools' design can protect us
from such security vulnerabilities anyway as we rely on passing the
dtb to the secondary kernel for arm64 kexec to work.

What I was suggesting in the previous mail was that instead of passing
a zero '/chosen/kaslr-seed' to the secondary/kexec kernel (which
effectively leads to a *nokaslr* behaviour), we can do the right thing
by using a entropy source (if available) to generate a random seed.

> (Speaking of kexec_file, we can easily adopt this approach as fdt modification
> is done totally inside the kernel. Likewise, "physical" randomization would be
> easy in part of arm64_relocate_new_kernel() because we only have to care bit 3
> of boot header's flags after Mark's comment.)

I think we need to handle both the kexec_load() and kexec_file_load()
cases transparently as the user may invoke either of them.

Just for my understanding - in the arm64  kexec_file_load() case we
don't pass the modified dtb via user-space to the secondary kernel.
Right (sorry I still haven't looked at the latest kexec_file_load()
patches yet)?

Thanks,
Bhupesh

>
>> For example, currently in the kernel we normally invoke 'update_fdt'
>> (inside 'drivers/fimrware/efi/libstub/fdt.c') from the UEFI stub,
>> wherein we have this check for CONFIG_RANDOMIZE_BASE:
>>
>> static efi_status_t update_fdt(efi_system_table_t *sys_table, void *orig_fdt,
>>                    unsigned long orig_fdt_size,
>>                    void *fdt, int new_fdt_size, char *cmdline_ptr,
>>                    u64 initrd_addr, u64 initrd_size)
>> {
>>
>> ...
>>     if (IS_ENABLED(CONFIG_RANDOMIZE_BASE)) {
>>         efi_status_t efi_status;
>>
>>         efi_status = efi_get_random_bytes(sys_table, sizeof(fdt_val64),
>>                           (u8 *)&fdt_val64);
>>         if (efi_status == EFI_SUCCESS) {
>>             status = fdt_setprop(fdt, node, "kaslr-seed",
>>                          &fdt_val64, sizeof(fdt_val64));
>>             if (status)
>>                 goto fdt_set_fail;
>>         } else if (efi_status != EFI_NOT_FOUND) {
>>             return efi_status;
>>         }
>>     }
>> ...
>> }
>>
>> I am thinking of modifying the kexec-tools code for arm64 (which
>> already processes the device tree to pass it to the secondary/kexec
>> kernel), so that we can do something like the following:
>>
>>         --> efi_get_random_bytes(sys_table, sizeof(fdt_val64),
>>                           (u8 *)&fdt_val64);
>>         ------> fdt_setprop(fdt, node, "kaslr-seed", &fdt_val64,
>> sizeof(fdt_val64));
>>
>> Now when the modified dtb is passed to the secondary/kexec kernel it
>> will automatically find a valid seed, will wipe it to zero for
>> security reasons and use the same to perform physical randomization.
>>
>> If this looks sensible I will try to take a stab at this approach and
>> share results on thread in the coming days.
>> Please share your inputs.
>>
>> Regards,
>> Bhupesh
