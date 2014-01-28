From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 28 Jan 2014 12:16:56 +0000
Subject: [Patch v3 2/2] dmaengine: qcom_bam_dma: Add device tree binding
In-Reply-To: <9156959.vu4XdoKglI@wuerfel>
References: <1390890471-14882-1-git-send-email-agross@codeaurora.org>
 <20140128113242.GJ10628@intel.com> <4916428.f0GtxdkWKj@wuerfel>
 <9156959.vu4XdoKglI@wuerfel>
Message-ID: <20140128121656.GH15937@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jan 28, 2014 at 01:08:47PM +0100, Arnd Bergmann wrote:
> On a related note, should we try to remove the slave_id field from
> the slave config structure as well? I believe it is still used by
> the shmobile dma engine in non-DT mode, but that is inconsistent with
> how all the others work, and with what the same driver does for DT.

I didn't see that appear, but now that it is there, I'm in two minds
about it.

The first is that the virtual channel approach is more flexible (one
virtual channel per DMA request line) since it allows users to hold on
to a DMA engine virtual channel and don't have the overhead of getting
that.  It also means that they have access to the DMA engine struct
device, which should be used with the DMA API for mapping/unmapping etc.

Another advantage is that it is possible (though we don't really do this
at present) to schedule a number of virtual channels onto the underlying
physical channels according to whatever algorithm(s) we decide.

The second point is that requesting a physical channel and then
configuring it seems more elegant from the DMA engine point of view - but
has the down-side that clients have to release the DMA engine channel
(and thus forget the struct device) as soon as possible to avoid starving
the system of physical DMA channels.

On balance, I think the virtual channel approach makes client drivers
more elegant and simpler, and makes the DMA engine API easier to use,
and gives greater flexibility for future improvements.  So, I wouldn't
miss the slave_id being removed.

-- 
FTTC broadband for 0.8mile line: 5.8Mbps down 500kbps up.  Estimation
in database were 13.1 to 19Mbit for a good line, about 7.5+ for a bad.
Estimate before purchase was "up to 13.2Mbit".
