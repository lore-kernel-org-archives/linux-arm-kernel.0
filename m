From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 12 Jun 2012 14:02:37 +0100
Subject: [PATCH 1/2] ARM: vexpress: Check master site in daughterboard's
 sysctl operations
In-Reply-To: <1339491487.3063.23.camel@linaro1.home>
References: <1339159835-32228-1-git-send-email-pawel.moll@arm.com>
 <1339491487.3063.23.camel@linaro1.home>
Message-ID: <1339506157.3063.37.camel@linaro1.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2012-06-12 at 09:58 +0100, Jon Medhurst (Tixy) wrote:
> On Fri, 2012-06-08 at 13:50 +0100, Pawel Moll wrote:
> > With recent enough motherboard firmware, core tile can be fitted
> > in either of the two daughterboard sites. The non-DT tile code for
> > V2P-CA9 did not check that when configuring DVI output nor setting
> > CLCD pixel clock.
> > 
> > Fixed now, providing "get master site" API in motherboard's code.
> > 
> > Signed-off-by: Pawel Moll <pawel.moll@arm.com>
> 
> This patch makes an Ubuntu boot always hang for me, about the time it
> would switch to GUI mode, it's not very consistent unfortunately.

I've found the cause of the problem, v2m_get_master_site() is marked
__init but is used by the non __init function ct_ca9x4_clcd_enable(). So
when Ubuntu GUI startup messes with the display it ends up calling into
freed memory.

Dropping __init from ct_ca9x4_clcd_enable() fixes my boot failures.

-- 
Tixy
