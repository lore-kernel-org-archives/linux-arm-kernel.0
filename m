From: heiko.carstens@de.ibm.com (Heiko Carstens)
Date: Fri, 27 May 2016 07:52:54 +0200
Subject: [PATCH 01/23] all: syscall wrappers: add documentation
In-Reply-To: <20160525.123017.1597296248000772613.davem@davemloft.net>
References: <1464048292-30136-1-git-send-email-ynorov@caviumnetworks.com>
 <1464048292-30136-2-git-send-email-ynorov@caviumnetworks.com>
 <20160525.123017.1597296248000772613.davem@davemloft.net>
Message-ID: <20160527055254.GA3820@osiris>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, May 25, 2016 at 12:30:17PM -0700, David Miller wrote:
> From: Yury Norov <ynorov@caviumnetworks.com>
> Date: Tue, 24 May 2016 03:04:30 +0300
> 
> > +To clear that top halves, automatic wrappers are introduced. They clear all
> > +required registers before passing control to regular syscall handler.
> 
> Why have one of these for every single compat system call, rather than
> simply clearing the top half of all of these registers unconditionally
> in the 32-bit system call trap before the system call is invoked?
> 
> That's what we do on sparc64.
> 
> And with that, you only need wrappers for the case where there needs
> to be proper sign extention of a 32-bit signed argument.

That would probably also work for arm. On s390 we still have these odd 31
bit pointers in compat mode which require us to clear 33 bits instead of 32
bits. That makes up for appr. one third of all system calls.

The additional wrappers are only for zero/sign extension, where I count a
total of 27 on s390.

The reason for doing this in C was the constant copy-paste error rate, when
adding new system calls plus I got a rid of a lot of unnecessary asm code.
