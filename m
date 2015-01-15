From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Jan 2015 10:42:17 +0100
Subject: [PATCH net-next v13 0/3] add hisilicon hip04 ethernet driver
In-Reply-To: <54B77C43.6010200@huawei.com>
References: <1421217254-12008-1-git-send-email-dingtianhong@huawei.com>
 <54B642B4.8010807@suse.de> <54B77C43.6010200@huawei.com>
Message-ID: <14674609.dERhba4yMV@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 January 2015 16:37:23 Ding Tianhong wrote:
> On 2015/1/14 18:19, Alexander Graf wrote:
> > 
> >>From a 10000 feet perspective it looks like two problems to me
> > 
> >   1) Allocation failure doesn't get handled properly somewhere

This is the bug that Eric pointed out as well.

> >   2) We fail to allocate with order=0 - I don't see why

GFP_ATOMIC. When allocating from a the napi poll function in softirq
context, you have to use nonblocking allocations, which occasionally
fail. This should not cause any harm other than dropped packets.

> is it easy to repetition this bug? how big is your memory on your board,
> is it happened in your previous hip04 driver?

It should be independent of memory size, but may be more likely if you
don't have swap space configured.

	Arnd
