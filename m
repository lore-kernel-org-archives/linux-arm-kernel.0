From: ard.biesheuvel@linaro.org (Ard Biesheuvel)
Date: Tue, 14 Oct 2014 12:26:02 +0200
Subject: [RFC PATCH] arm64/efi: use stable virtual mappings for UEFI
 runtime services
In-Reply-To: <20141014021721.GA4201@darkstar.nay.redhat.com>
References: <1412789936-4908-1-git-send-email-ard.biesheuvel@linaro.org>
 <1413240766.31184.69.camel@smoke>
 <20141014021721.GA4201@darkstar.nay.redhat.com>
Message-ID: <CAKv+Gu8v7yY6B4G69EtFmWacg=ifhTVn7cB3TEFgXpNoHhG0hQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 14 October 2014 04:17, Dave Young <dyoung@redhat.com> wrote:
> Hi, Geoff
>
> On 10/13/14 at 03:52pm, Geoff Levand wrote:
>> Hi Ard,
>>
>> On Wed, 2014-10-08 at 19:38 +0200, Ard Biesheuvel wrote:
>> > I haven't tested this code under kexec myself, but I have confirmed that
>> > the runtime services work as expected (rtc-efi and efivars). The comments
>> > that Mark Salter and Will Deacon gave on the id mapping patch here
>>
>> I applied this patch to my kexec master branch [1] and tested a basic
>> kexec re-boot using the FVP_Base_AEMv8A-AEMv8A_0.8_5602 model and the
>> 14.09 LEG EFI build.
>>
>> It crashes when the 2nd stage kernel is starting up on the first
>> dereference of the c16 variable in uefi_init():
>>
>>   c16 = early_memremap(efi.systab->fw_vendor, sizeof(vendor));
>>   if (c16) {
>>     for (i = 0; i < (int) sizeof(vendor) - 1 && *c16; ++i) {
>>                                                 ^^^^ crashes here
>>
>> early_memremap() returns 0xFFFFFFBFFBCBF618, and the dereference
>> starts the crash.  I did not look into it further.
>
> This is an expected behaviour as I mentioned before, we need save fw_vendor
> and the other two physical addresses and pass them to 2nd kernel.
>
> UEFI firmware will convert them to virtual address after entering virtual mode.
>

 Yes, you did point that out before, and I haven't addressed it in my patch.

But allow me to emphasize *again* that these issues will simply cease
to exist if we decide to not use SetVirtualAddressMap() at all, and
call the UEFI Runtime Services through their physical mappings.

Patch here
http://marc.info/?l=linux-arm-kernel&m=140681612407532&w=2

-- 
Ard.
