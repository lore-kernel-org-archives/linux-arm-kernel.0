From: eric.y.miao@gmail.com (Eric Miao)
Date: Wed, 23 Sep 2009 01:24:14 +0800
Subject: [PATCH 3/17] pxa: merge device struct in pxa910 and pxa168
In-Reply-To: <771cded00909142302u156bb1ecp6024fa682b2036e4@mail.gmail.com>
References: <771cded00909142302u156bb1ecp6024fa682b2036e4@mail.gmail.com>
Message-ID: <f17812d70909221024n4782f5d5i86ad519cffd96c43@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Sep 15, 2009 at 2:02 PM, Haojian Zhuang
<haojian.zhuang@gmail.com> wrote:
> From 3299ff750a63ff13332e72e13f05a2b79425ca47 Mon Sep 17 00:00:00 2001
> From: Haojian Zhuang <haojian.zhuang@marvell.com>
> Date: Tue, 8 Sep 2009 16:16:05 +0800
> Subject: [PATCH] pxa: merge device struct in pxa910 and pxa168
>
> device structure are both defined in pxa910 and pxa168. A lot of device are
> shared between pxa910 and pxa168. Merge them into device.c in order to keep
> code simple.
>
> Signed-off-by: Haojian Zhuang <haojian.zhuang@marvell.com>

Mmm....I'd prefer some redundancy so that:

1. you don't have to add a pxa168_device_* in pxa910 code (which is confusing)
2. you can handle the trivial difference easily between pxa168 and pxa910
   (e.g. IRQ, DMA channels, I/O memory range)
3. this is flexible to extend to future SoC

The drawback is a little bit waste of memory since some common definitions
are not grouped, and that's why I invented 'struct pxa_device_desc', which
tends to be small, and all those heavy 'struct platform_device's are created
dynamically.
