From: dhowells@redhat.com (David Howells)
Date: Tue, 31 Jan 2017 18:59:22 +0000
Subject: [PATCH 6/7] efi: Handle secure boot from UEFI-2.6 [ver #7]
In-Reply-To: <CAKv+Gu8dnKB1sRGb3U+XB1eoA7Eyo4qSFBtPRbvGV912xPViVw@mail.gmail.com>
References: <CAKv+Gu8dnKB1sRGb3U+XB1eoA7Eyo4qSFBtPRbvGV912xPViVw@mail.gmail.com>
 <148587558696.4026.16034622623568539004.stgit@warthog.procyon.org.uk>
 <148587564847.4026.5759345672956585977.stgit@warthog.procyon.org.uk>
Message-ID: <10454.1485889162@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:

> > UEFI-2.6 adds a new variable, DeployedMode.  If it exists, this must be 1
> > if we're to engage lockdown mode.
> >
> > Reported-by: James Bottomley <James.Bottomley@HansenPartnership.com>
> > Signed-off-by: David Howells <dhowells@redhat.com>
> 
> Interestingly, the string 'DeployedMode' appears zero times in the
> EDK2 codebase, so I wonder if it makes any sense to merge this now.
> The string 'AuditMode' does appear once, but in a comment

It's in the standard, so shouldn't we check for it?

> In any case, the logic is not entirely correct either: apologies if it
> was me who caused any confusion here, but it seems DeployedMode could
> legally be 0 or 1 while secure boot is in fact enabled. It is actually
> AuditMode that should be taken into account here, i.e., if AuditMode
> == 1, the firmware ignores invalid or missing signatures. If
> SecureBoot == 0x1, SetupMode == 0x0 and AuditMode == 0x0 (or
> non-existent), signature verification is performed regardless of the
> value (or existence) of DeployedMode.
> 
> So I propose to respin this patch to treat AuditMode == 0x1 as 'secure
> boot disabled', and ignore if it is missing.

Ummm...  This might conflict what said:

| Since you seem to be using this to mean "is the platform locked down?",
| this looks to be no longer complete in the UEFI 2.6 world.  If
| DeployedMode == 0, even if SecureBoot == 1 and SetupMode == 0, you can
| remove the platform key by writing 1 to AuditMode and gain control of
| the secure variables.  The lock down state becomes DeployedMode == 1,
| SecureBoot == 1 and SetupMode == 0
| 
| See the diagram on page 1817
| 
| http://www.uefi.org/sites/default/files/resources/UEFI%20Spec%202_6.pdf

Looking again at that diagram, should I be checking all four variables
(SecureBoot, SetupMode, DeployedMode and AuditMode)?  And/or should I treat
audit mode differently to deployed mode?

Further, there doesn't seem to be a state in which SecureBoot is shown as
being 1.

David
