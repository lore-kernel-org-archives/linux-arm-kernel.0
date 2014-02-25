From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Tue, 25 Feb 2014 12:24:24 +0000
Subject: Ideas/suggestions to avoid repeated locking and reducing too
 many lists with dmaengine?
In-Reply-To: <20140224205028.GA24339@qualcomm.com>
References: <530B9784.5060904@ti.com> <20140224205028.GA24339@qualcomm.com>
Message-ID: <20140225122424.GW27282@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Feb 24, 2014 at 02:50:28PM -0600, Andy Gross wrote:
> On Mon, Feb 24, 2014 at 01:03:32PM -0600, Joel Fernandes wrote:
> > Hi folks,
> > 
> > Just wanted your thoughts/suggestions on how we can avoid overhead in the EDMA
> > dmaengine driver. I am seeing a lots of performance drop specially for small
> > transfers with EDMA versus before raw EDMA was moved to DMAEngine framework
> > (atleast 25%).
> 
> I've seen roughly the same drop in my testing.  In my case it had to do
> with the nature of how work is done using virt-dma.  The virt-dma is
> predicated on only letting one transaction be active at a time and it
> increases the latency for getting the next transaction off.  For large
> transactions, it's negligible.  But for small transactions, it is pretty
> evident.

Wrong.  virt-dma allows you to fire off the next transaction in the queue
immediately that the previous transaction has finished.  I know this,
because sa11x0-dma does exactly that.

You don't need to wait for the tasklet to be called before starting the
next transaction.

-- 
FTTC broadband for 0.8mile line: now at 9.7Mbps down 460kbps up... slowly
improving, and getting towards what was expected from it.
