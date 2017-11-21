From: David.Laight@ACULAB.COM (David Laight)
Date: Tue, 21 Nov 2017 16:25:09 +0000
Subject: [PATCH v2 4/4] PCI/AER: Dont do recovery when DPC is enabled
In-Reply-To: <16e82fb4-dda8-3790-e831-675f9a6fd388@codeaurora.org>
References: <1510721808-27164-1-git-send-email-poza@codeaurora.org>
 <1510721808-27164-5-git-send-email-poza@codeaurora.org>
 <20171115211447.GA7266@bhelgaas-glaptop.roam.corp.google.com>
 <16e82fb4-dda8-3790-e831-675f9a6fd388@codeaurora.org>
Message-ID: <de047a7ce7334daab4e53ea4e8444421@AcuMS.aculab.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Sinan Kaya
> Sent: 16 November 2017 14:04
...
> The issue is two independent software entities are trying to recover the PCIe
> link simultaneously. AER and DPC have two different approaches to link recovery.
> 
> AER makes a callback into the endpoint drivers for non-fatal errors and hope
> that endpoint driver can recover the link. AER also makes a callback in the
> fatal error case but resets the link via secondary bus reset.
> 
> The DPC on the other hand stops the drivers immediately since HW took care of
> link disable. (Endpoint register reads return ~0 at this point.)

What happens if the 'user' driver doesn't define the error reporting callbacks?
It might be hardened against the ~0u returns from reads - so not OOPS.
It might be appropriate to call the remove() function instead.

> DPC driver clears
> the interrupt from the DPC capability and brings the link up at the end. Full
> enumeration/rescan follows this procedure to go back to functioning state.

That might not be a good idea, very likely it will fail again immediately.

	David
