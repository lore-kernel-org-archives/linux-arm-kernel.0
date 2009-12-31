From: haojian.zhuang@gmail.com (Haojian Zhuang)
Date: Wed, 30 Dec 2009 20:57:14 -0500
Subject: [PATCH 2/2] pxa: enable L2 if present in XSC3
In-Reply-To: <alpine.LFD.2.00.0912301305170.4177@xanadu.home>
References: <771cded00912292328j459b5218r64703d59165fe98f@mail.gmail.com>
	<f17812d70912300050p24c0fb2ayd6f68ffc01a67529@mail.gmail.com>
	<alpine.LFD.2.00.0912301305170.4177@xanadu.home>
Message-ID: <771cded00912301757t164b2f2cx829977547122eaff@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Dec 30, 2009 at 1:06 PM, Nicolas Pitre <nico@fluxnic.net> wrote:
> On Wed, 30 Dec 2009, Eric Miao wrote:
>
>> On Wed, Dec 30, 2009 at 3:28 PM, Haojian Zhuang
>> <haojian.zhuang@gmail.com> wrote:
>> > From 2c4a7d0e907df9a762c5c9f0ec48b3b7860e1f7c Mon Sep 17 00:00:00 2001
>> > From: Haojian Zhuang <haojian.zhuang@marvell.com>
>> > Date: Wed, 30 Dec 2009 10:02:57 -0500
>> > Subject: [PATCH] [ARM] pxa: enable L2 if present in XSC3
>> >
>> > Check whether L2 is present or not in XSC3. If it's present, enable L2
>> > immediately.
>> >
>> > Disabling L2 after L2 is enabled that would result in unpredicatable behavior
>> > of XSC3 processor.
>> >
>>
>> You may want to enclose this with #ifdef CONFIG_CACHE_XSC3L2 .. #endif
>> at least, to allow L2 to remain disabled even if L2 is present.
>
> Also... might be a good idea to invalidate L2 before enabling it.
>

XSC3 supports these L2 operations in below.
1) invalidate L2 cache line (parameter is MVA)
2) clean L2 cache line (parameter is MVA)
3) clean L2 cache line (parameter is set/way)
4) clean and invalidate L2 cache line (parameter is set/way)

The most important thing is we couldn't call these L2 operations while
L2 is disabled.

"The behavior of these operations is unpredictable if the L2 cache is
disabled. If the L2 is not present, these operations performs no-ops."

I copied above words from XSC3 core spec at here. My opinion is that
not perform any L2 operations if L2 is disabled.

Thanks
Haojian
