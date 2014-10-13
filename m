From: geoff.levand@linaro.org (Geoff Levand)
Date: Mon, 13 Oct 2014 15:52:46 -0700
Subject: [RFC PATCH] arm64/efi: use stable virtual mappings for UEFI
 runtime services
In-Reply-To: <1412789936-4908-1-git-send-email-ard.biesheuvel@linaro.org>
References: <1412789936-4908-1-git-send-email-ard.biesheuvel@linaro.org>
Message-ID: <1413240766.31184.69.camel@smoke>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Ard,

On Wed, 2014-10-08 at 19:38 +0200, Ard Biesheuvel wrote:
> I haven't tested this code under kexec myself, but I have confirmed that
> the runtime services work as expected (rtc-efi and efivars). The comments
> that Mark Salter and Will Deacon gave on the id mapping patch here

I applied this patch to my kexec master branch [1] and tested a basic
kexec re-boot using the FVP_Base_AEMv8A-AEMv8A_0.8_5602 model and the
14.09 LEG EFI build.

It crashes when the 2nd stage kernel is starting up on the first
dereference of the c16 variable in uefi_init():

  c16 = early_memremap(efi.systab->fw_vendor, sizeof(vendor));
  if (c16) {
    for (i = 0; i < (int) sizeof(vendor) - 1 && *c16; ++i) {
                                                ^^^^ crashes here

early_memremap() returns 0xFFFFFFBFFBCBF618, and the dereference
starts the crash.  I did not look into it further.

[1] https://git.linaro.org/people/geoff.levand/linux-kexec.git

-Geoff
