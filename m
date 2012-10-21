From: rabin@rab.in (Rabin Vincent)
Date: Sun, 21 Oct 2012 20:15:53 +0200
Subject: [PATCH 3/9] uprobes: allow ignoring of probe hits
In-Reply-To: <20121017173510.GA11019@redhat.com>
References: <1350242593-17761-1-git-send-email-rabin@rab.in>
 <1350242593-17761-3-git-send-email-rabin@rab.in>
 <20121015165218.GA10239@redhat.com>
 <CAH+eYFBHXAWTinnVO8vEnEhFDQLibwo+BtxYJJYdPcG9__n5OQ@mail.gmail.com>
 <20121017173510.GA11019@redhat.com>
Message-ID: <20121021181504.GA4840@ubuntu>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 17, 2012 at 07:35:10PM +0200, Oleg Nesterov wrote:
> On 10/16, Rabin Vincent wrote:
> > 2012/10/15 Oleg Nesterov <oleg@redhat.com>:
> > > Not sure I understand why we shouldn't call handlers in this case,
> > > but OK, I know nothing about arm.
> >
> > This old discussion about kprobes should be useful:
> >
> > http://lists.infradead.org/pipermail/linux-arm-kernel/2011-March/045755.html
> 
> Thanks... Not sure I understand this discussion...
> 
> And, to clarify, I am not arguing. Just curious.
> 
> So, is this like cmov on x86? And this patch allows to not report if
> the condition is not true? Or there are other issues on arm?

Yes, I guess this is like CMOV on x86.  In the ARM instruction set most
instructions can be conditionally executed.

In order to set the probe on a conditional instruction, we use an
undefined instruction with the same condition as the instruction we
replace.  However, it is implementation defined whether an undefined
instruction with a failing condition code will trigger an undefined
instruction exception or just be executed as a NOP.  So for those
processor implementations where we do get the undefined instruction
exception even for a failing condition code, we have to ignore it in
order to provide consistent behaviour.
