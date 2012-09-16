From: paul@pwsan.com (Paul Walmsley)
Date: Sun, 16 Sep 2012 01:22:01 +0000 (UTC)
Subject: [PATCH v4 00/21] OMAP UART Patches
In-Reply-To: <20120912062259.GC18563@arwen.pp.htv.fi>
References: <20120906122948.GC29202@arwen.pp.htv.fi>
 <1346935540-1792-1-git-send-email-balbi@ti.com>
 <alpine.DEB.2.00.1209062137000.11516@utopia.booyaka.com>
 <alpine.DEB.2.00.1209112141220.9444@utopia.booyaka.com>
 <20120912062259.GC18563@arwen.pp.htv.fi>
Message-ID: <alpine.DEB.2.00.1209160117510.23371@utopia.booyaka.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, 12 Sep 2012, Felipe Balbi wrote:

> On Tue, Sep 11, 2012 at 10:02:48PM +0000, Paul Walmsley wrote:
> 
> > The bad news is that N800 no longer boots -- or the UART dies during 
> > serial init:
> > 
> > http://www.pwsan.com/omap/testlogs/test_tty_next_e36851d0/20120910020323/boot/2420n800/2420n800_log.txt
> > 
> > The problem doesn't seem to affect the 2430SDP.
> > 
> > Could you put together a patch to fix N800?

Bisected this down.  It's this one that causes the problem on N800:

commit 93220dcc3052182e7156c09655ad1316055564b9
Author: Felipe Balbi <balbi@ti.com>
Date:   Thu Sep 6 15:45:27 2012 +0300

    serial: omap: set dev->drvdata before enabling pm_runtime
    
    by the time we call our first pm_runtme_get_sync()
    after enable pm_runtime, our resume method might
    be called. To avoid problems, we must make sure
    that our dev->drvdata is set correctly before
    our resume method gets called.
    
    Tested-by: Shubhrajyoti D <shubhrajyoti@ti.com>
    Acked-by: Santosh Shilimkar <santosh.shilimkar@ti.com>
    Signed-off-by: Felipe Balbi <balbi@ti.com>
    Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

- Paul
