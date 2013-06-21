From: catalin.marinas@arm.com (Catalin Marinas)
Date: Fri, 21 Jun 2013 15:22:38 +0100
Subject: [PATCH] arm64: Add support to pass earlyprintk argument via
 device tree
In-Reply-To: <CAAHg+HhhVOLn1DXizWAKOqZXczq9YR8dOXM+u=ywbEakw6A6ZQ@mail.gmail.com>
References: <1370274671-23812-1-git-send-email-pranavkumar@linaro.org>
 <20130612132820.992E73E0A56@localhost>
 <CAAHg+HhhVOLn1DXizWAKOqZXczq9YR8dOXM+u=ywbEakw6A6ZQ@mail.gmail.com>
Message-ID: <20130621142238.GB8384@darko.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Jun 13, 2013 at 07:25:20AM +0100, Pranavkumar Sawargaonkar wrote:
> On 12 June 2013 18:58, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Mon,  3 Jun 2013 21:21:11 +0530, Pranavkumar Sawargaonkar
> > <pranavkumar@linaro.org> wrote:
> >> One can just append earlyprintk=device-type,address (same as we pass
> >> through command line) in "/chosen" node to notify kernel which is the
> >> earlyprintk device and what is its address.
> >
> > I'm not a big fan of this. It seems to be short-circuiting around
> > existing properties. The kernel /should/ be able to use the
> > linux,stdout-path property to determine what the earlyprintk device
> > to use is.
> 
> For this there are two problems:
> 
> 1. Early printk code gets initialized before un-flattening of a device tree.
> Hence trying to find out node from stdout-path is tricky as we do not have
> of_find_node_by_path available.

Looking at the existing uses of linux,stdout-path, it seems that it is
pointed at an existing entry like &uart0, which cannot be parsed early
enough. The base address is the main problem as it needs the DT to be
unflattened (for example v2m_serial0 on arm64 would read as 0x90000
which is just an offset). If you pass the full path,
of_find_node_by_path() wouldn't work either this early.

Question for the DT guys - would it be feasible to pass a
@<phys address> via the linux,stdout-path? Any other way to get the phys
address of the device early during boot?

> 2. Current compatible strings in arm64 early printk code are not in
> synced (or different) from actual compatible strings used in drivers -
> e.g. for PL011 In earlyprintk code match name is just pl011 but in dts
> it is specified as "arm,pl011" Hence we will need multiple changes to
> implement it.

I think we can sort this out. The first point is more important.

-- 
Catalin
