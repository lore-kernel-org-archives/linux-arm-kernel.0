From: gregkh@linuxfoundation.org (gregkh at linuxfoundation.org)
Date: Mon, 17 Jul 2017 16:18:40 +0200
Subject: [PATCH v3] drivers/char: kmem: disable on arm64
In-Reply-To: <CAKv+Gu_nOo3VfjHistipR7vhaTnO89M8X1rrePgk3jhK0xnYVA@mail.gmail.com>
References: <1497941940-2699-1-git-send-email-ard.biesheuvel@linaro.org>
 <CAKv+Gu_nOo3VfjHistipR7vhaTnO89M8X1rrePgk3jhK0xnYVA@mail.gmail.com>
Message-ID: <20170717141840.GA16198@kroah.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 20, 2017 at 01:20:49PM +0200, Ard Biesheuvel wrote:
> On 20 June 2017 at 08:59, Ard Biesheuvel <ard.biesheuvel@linaro.org> wrote:
> > As it turns out, arm64 deviates from other architectures in the way it
> > maps the VMALLOC region: on most (all?) other architectures, it resides
> > strictly above the kernel's direct mapping of DRAM, but on arm64, this
> > is the other way around. For instance, for a 48-bit VA configuration,
> > we have
> >
> >   modules : 0xffff000000000000 - 0xffff000008000000   (   128 MB)
> >   vmalloc : 0xffff000008000000 - 0xffff7dffbfff0000   (129022 GB)
> >   ...
> >   vmemmap : 0xffff7e0000000000 - 0xffff800000000000   (  2048 GB maximum)
> >             0xffff7e0000000000 - 0xffff7e0003ff0000   (    63 MB actual)
> >   memory  : 0xffff800000000000 - 0xffff8000ffc00000   (  4092 MB)
> >
> > This has mostly gone unnoticed until now, but it does appear that it
> > breaks an assumption in the kcore
> 
> s/kcore/kmem/

v4?  :)
