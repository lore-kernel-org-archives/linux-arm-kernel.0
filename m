From: okaya@codeaurora.org (Sinan Kaya)
Date: Fri, 16 Mar 2018 17:46:16 -0400
Subject: [PATCH v3 18/18] infiniband: cxgb4: Eliminate duplicate barriers
 on weakly-ordered archs
In-Reply-To: <003601d3bd6a$783d6970$68b83c50$@opengridcomputing.com>
References: <1521216991-28706-1-git-send-email-okaya@codeaurora.org>
 <1521216991-28706-19-git-send-email-okaya@codeaurora.org>
 <003601d3bd6a$783d6970$68b83c50$@opengridcomputing.com>
Message-ID: <83387f6e-adcb-14e9-2c22-96abf9493cc6@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 3/16/2018 5:05 PM, Steve Wise wrote:
>> Code includes wmb() followed by writel(). writel() already has a barrier
> on
>> some architectures like arm64.
>>
>> This ends up CPU observing two barriers back to back before executing the
>> register write.
>>
>> Since code already has an explicit barrier call, changing writel() to
>> writel_relaxed().
>>
>> Signed-off-by: Sinan Kaya <okaya@codeaurora.org>
> 
> NAK - This isn't correct for PowerPC.  For PowerPC, writeX_relaxed() is just
> writeX().  
> 
> I was just looking at this with Chelsio developers, and they said the
> writeX() should be replaced with __raw_writeX(), not writeX_relaxed(), to
> get rid of the extra barrier for all architectures.

OK. I can do that but isn't the problem at PowerPC adaptation?

/*
 * We don't do relaxed operations yet, at least not with this semantic
 */
#define readb_relaxed(addr)	readb(addr)
#define readw_relaxed(addr)	readw(addr)
#define readl_relaxed(addr)	readl(addr)
#define readq_relaxed(addr)	readq(addr)
#define writeb_relaxed(v, addr)	writeb(v, addr)
#define writew_relaxed(v, addr)	writew(v, addr)
#define writel_relaxed(v, addr)	writel(v, addr)
#define writeq_relaxed(v, addr)	writeq(v, addr)

Why don't we fix the PowerPC's relaxed operators? Is that a bigger task?

>From API perspective both __raw_writeX() and writeX_relaxed() are correct.
It is just PowerPC doesn't seem the follow the definition yet.
