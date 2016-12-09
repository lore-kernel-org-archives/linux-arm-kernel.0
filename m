From: lukas@wunner.de (Lukas Wunner)
Date: Fri, 9 Dec 2016 01:35:27 +0100
Subject: [PATCH 5/8] efi: Get the secure boot status [ver #5]
In-Reply-To: <14655.1481218273@warthog.procyon.org.uk>
References: <20161208124236.GA8757@wunner.de> <20161208065735.GB8549@wunner.de>
 <148111668193.23390.6340512985876251017.stgit@warthog.procyon.org.uk>
 <148111671977.23390.12452925207541146423.stgit@warthog.procyon.org.uk>
 <6009.1481184981@warthog.procyon.org.uk>
 <14655.1481218273@warthog.procyon.org.uk>
Message-ID: <20161209003527.GA9062@wunner.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Dec 08, 2016 at 05:31:13PM +0000, David Howells wrote:
> Lukas Wunner <lukas@wunner.de> wrote:
> > > +out_efi_err:
> > > +	pr_efi_err(sys_table_arg, "Could not determine UEFI Secure Boot status.\n");
> > > +	if (status == EFI_NOT_FOUND)
> > > +		return efi_secureboot_mode_disabled;
> > > +	return efi_secureboot_mode_unknown;
> > > +}
> > 
> > In the out_efi_err path, the if-statement needs to come before the
> > pr_efi_err() call.  Otherwise it would be a change of behaviour for
> > ARM to what we have now.
> 
> As I understand it, if the BIOS is an EFI BIOS, these variables must exist -
> in which case I would argue that the pr_efi_err-statement should be before
> the if-statement.

The existing efi_get_secureboot() in arm-stub.c returns 0 in the
EFI_NOT_FOUND case and the "Could not determine ..."  error is only
printed if the return value is < 0.  So you're introducing a change
of behaviour.

If you feel the change is justified, fine, I won't argue against it
since I don't have a dog in this fight.

But obviously it's something that a reader of your patch will trip over,
so@least explain it in the commit message.  It would also be good to
explain why you're moving the pr_efi_err() calls in the first place.
ISTR it has to do with the different interpretation of an error,
what I wrote in my previous e-mail: x86 defaults to considering secureboot
disabled on error, ARM to enabled.  I'm not even sure that's correct,
I'd have to go re-read the whole thread, which again shows that there's
too little documentation in the commit message.

Thanks,

Lukas
