From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Fri, 20 Mar 2015 13:50:37 +0100
Subject: [PATCH v3] arm64: enforce x1|x2|x3 == 0 upon kernel entry as per
 boot protocol
In-Reply-To: <20150320122502.GA1474@arm.com>
References: <20150319104100.GB18473@leverpostej>
 <1426762852-13699-1-git-send-email-ard.biesheuvel@linaro.org>
 <20150319133612.GD18473@leverpostej>
 <CAKv+Gu-=n8fbdFeZX=EEpLypOdu0xXePzXH4-gOn6SqufA6CGg@mail.gmail.com>
 <20150320114142.GF14766@leverpostej>
 <CAKv+Gu88xUKaW9inod2=4sfBesZRxojVMnWzjugB+W0WnD=Vyw@mail.gmail.com>
 <20150320122502.GA1474@arm.com>
Message-ID: <CAKv+Gu8NKRdQ423UW4okkm_G9jwKqwrKrEJAsD6Ao3ezrgqs5A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 20 March 2015 at 13:25, Will Deacon <will.deacon@arm.com> wrote:
> On Fri, Mar 20, 2015 at 11:45:17AM +0000, Ard Biesheuvel wrote:
>> On 20 March 2015 at 12:41, Mark Rutland <mark.rutland@arm.com> wrote:
>> >> >> +     if (boot_args[1] || boot_args[2] || boot_args[3]) {
>> >> >> +             pr_err("WARNING: boot protocol violation detected (x1 == %llx, x2 == %llx, x3 == %llx)\n",
>> >> >> +                     boot_args[1], boot_args[2], boot_args[3]);
>> >> >> +             pr_err("WARNING: your bootloader may fail to load newer kernels\n");
>> >> >
>> >> > If we ever decide to use x1-x3 for something, and try to boot an older
>> >> > kernel, that warning is going to be a bit misleading. That could matter
>> >> > for VMs where we're going to see old kernel images for a long time.
>> >> >
>> >> > I would like the warning to mention that could be the case.
>> >> >
>> >> > It would also be nice if the message were consistently spaced regardless
>> >> > of the values of x1-x3, so we should zero-pad them (and as that takes a
>> >> > resonable amount of space, let's give them a line each).
>> >> >
>> >> > So could we change the warning to be something like:
>> >> >
>> >> >         pr_err("WARNING: x1-x3 nonzero in violation of boot protocol:\n"
>> >> >                "\tx1: %016llx\n\tx2: %016llx\n\tx3: %016llx\n"
>> >> >                "This indicates a broken bootloader or old kernel\n",
>> >> >                boot_args[1], boot_args[2], boot_args[3]);
>> >> >
>> >>
>> >> OK, I have applied this change.
>> >>
>> >> But I would like to note that we should probably only extend the boot
>> >> protocol in a way that would not trigger this on older kernels in the
>> >> first place.
>> >> I.e., assign a bit in the flags field in the header, which indicates
>> >> whether some boot protocol enhancement is supported by the kernel
>> >> being loaded, and only allow x1/x2/x3 to be non-zero if said
>> >> enhancement defines that.
>> >
>> > Good point.
>> >
>> > Given that, if you want to restore your original last line, that would
>> > be fine with me (and my Ack still applies).
>> >
>>
>> I think it's fine to leave it as is
>
> Yup, and this is sitting pretty on the arm64 devel branch.
>
> Ard: I also pushed a kvm-bounce-page branch for you. Next step would be to
> merge everything into for-next/core and put your VA changes on top of that.
>
> I'd appreciate a sanity check of the current branch first, though!
>

OK, I pulled devel and put the KVM and VA branches on top, and
everything builds and runs fine afaict.

I also checked that Arnd's dotconfig from hell does not have the false
negative on the HYP text size assert.

"""
0x00000001                ASSERT ((((__hyp_idmap_text_start & 0xfff) +
__hyp_idmap_size) <= 0x1000), , HYP init code too big or misaligned)
"""

(Note that this .config does not even produce a bootable zImage.)

You will get a conflict in head.S when you merge the core VA range patch.
Nothing major but I'm happy to resend the patch.
