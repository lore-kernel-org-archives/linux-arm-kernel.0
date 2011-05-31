From: linus.walleij@stericsson.com (Linus Walleij)
Date: Tue, 31 May 2011 17:44:25 +0200
Subject: is there the sample for how to use the tcm on userspace ?
In-Reply-To: <BANLkTi=XY2pkENWGacj77wAFf2A0i0V=sg@mail.gmail.com>
References: <BANLkTi=_1cXiQ6A6fCmfywyHHAOvB3DQpA@mail.gmail.com>	<4DE4A2AF.2040708@stericsson.com>	<BANLkTi=aDBjBsAx0XwL1HRKCnO1=2wHaVA@mail.gmail.com>	<4DE4A8D4.2090208@stericsson.com>
	<BANLkTi=XY2pkENWGacj77wAFf2A0i0V=sg@mail.gmail.com>
Message-ID: <4DE50CD9.3050506@stericsson.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/31/2011 11:35 AM, Jello huang wrote:
> It is easy to define the interface .But
> on ARM11 (ARM10?):
>
>     CPU
>      |
>     MMU
>     / \
> Cache TCM
>  |
> External memory interface

This is how all TCM works, it's behind the MMU but you can *also*
move it in physical address space.

> If we use TCM from userspace whether it directly use  TCM or it need 
> through MMU

You need to get hold of the memory somehow, but there is code in
the kernel managing it as a memory pool, so you need a userspace
interface to tcm_alloc() and tcm_free() and the resulting handles.

> And how much benefit we can get when we use the SDRAM or TCM from 
> usespace.

Define benefit, plus this depends on the bus and cache topology and
frequency of your system.

Frank Rowand presented a very compelling case for using on-chip
memory in the critical latency paths to avoid cache stalls on SMP
systems:
http://www.elinux.org/images/d/dd/Elc2011_rowand.pdf

However my TCM interface is not yet SMP aware. I was planning
to try to fix it for the PB11MPcore (which has per-cpu TCM!) someday
as an interesting exercise. But that depend on time and planning etc.

Yours,
Linus Walleij
