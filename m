From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Mon, 15 Sep 2014 09:49:40 +0100
Subject: [PATCH] ahci_xgene: Fix the error print invalid resource for
 APM X-Gene SoC AHCI SATA Host Controller driver.
In-Reply-To: <20140915074452.GC11267@mtj.dyndns.org>
References: <1410508448-25111-1-git-send-email-stripathi@apm.com>
 <1410508448-25111-2-git-send-email-stripathi@apm.com>
 <20140912175014.GA6298@mtj.dyndns.org>
 <CAOHikRA8LiNkMuzqe-Kgrf4QWbJ_jpXRGHdf+rsrCmq6R0GjDg@mail.gmail.com>
 <20140914093911.GB9028@mtj.dyndns.org>
 <CAOHikRAFM-FETGGXroNV39Yi-jChMA-W37ufhiMx4O2WgWpxFg@mail.gmail.com>
 <CAOHikRDdfKTxCXHGsywP+c8=1eLmMCf3fuC2pmH2WH-6ymHMAA@mail.gmail.com>
 <20140915074452.GC11267@mtj.dyndns.org>
Message-ID: <20140915084940.GY12361@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Sep 15, 2014 at 04:44:52PM +0900, Tejun Heo wrote:
> On Mon, Sep 15, 2014 at 01:10:01PM +0530, Suman Tripathi wrote:
> > [suman] : So the posted version is acceptable ? Any others comments on this
> > patch ?
> 
> I'm suggesting setting ctx->cs_mux to NULL on failure.  IOW,
> 
> 	if (res) {
> 		ctx->csr_mux = devm_ioremap_resources();
> 		if (IS_ERR(ctx->csr_mux)) {
> 			print warning or something;
> 			ctx->csr_mux = NULL;
> 		}
> 	}

A much better approach is:

	if (res) {
		void __iomem *csr = devm_ioremap_resources();
		if (IS_ERR(csr)) {
			ret = ERR_PTR(csr);
			dev_xxx();
			goto err;
		}

		ctx->csr_mux = csr;
	}

Then you never end up in the situation where csr_mux contains an error
pointer value - and is much more obvious that is the case.

-- 
FTTC broadband for 0.8mile line: currently at 9.5Mbps down 400kbps up
according to speedtest.net.
