From: m-karicheri2@ti.com (Murali Karicheri)
Date: Wed, 30 Jul 2014 15:34:44 -0400
Subject: [PATCH v7 4/5] PCI: add PCI controller for keystone PCIe h/w
In-Reply-To: <20140723174228.GB11270@obsidianresearch.com>
References: <1405961925-27248-1-git-send-email-m-karicheri2@ti.com>
 <1405961925-27248-5-git-send-email-m-karicheri2@ti.com>
 <20140722223527.GA27965@google.com> <53CEEB1C.9020202@ti.com>
 <20140722235200.GC27965@google.com>
 <20140723174228.GB11270@obsidianresearch.com>
Message-ID: <53D948D4.6080603@ti.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/23/2014 01:42 PM, Jason Gunthorpe wrote:
> On Tue, Jul 22, 2014 at 05:52:00PM -0600, Bjorn Helgaas wrote:
>> If there is a hardware defect, a PCI quirk is a reasonable way to work
>> around it, since that's the main purpose of quirks.  fixup_mpss_256()
>> is an example of something that sounds superficially similar.
>
> It was my suggestion to engage the PCI-E tuning code. By my
> understanding the HW bug is that read response segmentation at the
> host bridge does not work - so all read requests from any downstream
> device must have responses that fit within a single packet.
>

In the case of Keystone PCI, when I set the MRSS to 256 in the EP, PCI 
controller is able to function properly. Keystone spec says.

? Maximum outbound payload size of 128 bytes
? Maximum inbound payload size of 256 bytes
? Maximum remote read request size of 256 bytes

I am interpreting the "Maximum remote read request size" to indicate it 
can's handle if it exceeds the limit. It has an outbound payload size of 
128 bytes. So in this case a read request would results in 2 completion 
packets. So it seems to be able to segment up to maximum 256 bytes of 
read request. Where do I find the requirement in PCI spec that "read 
response segmentation at the host bridge does not work" ?

> This is completely against how the spec envisions things working,
> segmentation is a mandatory function. As you point out there is no
> parameter bounding the maximum read request size that a completer will
> accept.
>
> So, the only fix is that every downstream device must always have a
> MRSS set to less than the MPS of the host bridge.

Why this can't be the default behavior in the PCI core? Any cons?

Murali
>
> Which means the tuning code must be involved somehow, as that code
> controls the MRSS of unrelated devices...
>
> Regards,
> Jason
