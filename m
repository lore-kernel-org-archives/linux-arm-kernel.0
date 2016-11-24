From: James.Bottomley@HansenPartnership.com (James Bottomley)
Date: Thu, 24 Nov 2016 11:41:27 -0800
Subject: [PATCH 5/7] efi: Get the secure boot status [ver #3]
In-Reply-To: <147990565051.7576.9673287945782426886.stgit@warthog.procyon.org.uk>
References: <147990561294.7576.6464430479448167484.stgit@warthog.procyon.org.uk>
 <147990565051.7576.9673287945782426886.stgit@warthog.procyon.org.uk>
Message-ID: <1480016487.2444.18.camel@HansenPartnership.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 2016-11-23 at 12:54 +0000, David Howells wrote:
> Get the firmware's secure-boot status in the kernel boot wrapper and 
> stash it somewhere that the main kernel image can find.
> 
> The efi_get_secureboot() function is extracted from the arm stub and 
> (a) generalised so that it can be called from x86 and (b) made to use
> efi_call_runtime() so that it can be run in mixed-mode.
> 
> Suggested-by: Lukas Wunner <lukas@wunner.de>
> Signed-off-by: David Howells <dhowells@redhat.com>

Since you seem to be using this to mean "is the platform locked down?",
this looks to be no longer complete in the UEFI 2.6 world.  If
DeployedMode == 0, even if SecureBoot == 1 and SetupMode == 0, you can
remove the platform key by writing 1 to AuditMode and gain control of
the secure variables.  The lock down state becomes DeployedMode == 1,
SecureBoot == 1 and SetupMode == 0

See the diagram on page 1817

http://www.uefi.org/sites/default/files/resources/UEFI%20Spec%202_6.pdf

James
