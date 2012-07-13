From: will.deacon@arm.com (Will Deacon)
Date: Fri, 13 Jul 2012 10:42:32 +0100
Subject: ARM: why smp_mb() is not needed in the "__mutex_fastpath_lock"
 and "__mutex_fastpath_unlock" functions
In-Reply-To: <CAK2TD5z2DticZAQ-Pxzo7YT9tx=YWZkwcn-YZJ3aQa4AFoE_Cw@mail.gmail.com>
References: <CAK2TD5ygowdy9t1TpfxAPbpvNQfMnMB-3Zp8TKMsTYtBZdGW=Q@mail.gmail.com>
 <CAFNq8R6dNb0BrDVZScJ8s=P3B-OMgtr8tUdy8XqQcCAeUWuH+A@mail.gmail.com>
 <CAK2TD5z2DticZAQ-Pxzo7YT9tx=YWZkwcn-YZJ3aQa4AFoE_Cw@mail.gmail.com>
Message-ID: <20120713094232.GD18079@mudshark.cambridge.arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Jul 13, 2012 at 10:10:52AM +0100, shan kang wrote:
> For example, in the following scenario, Process2  may get the wrong value;
> Process1:
> mutex_lock(&lock);
> write data; (store operation)
> mutex_unlock(&lock);
> 
> Process2:
> mutex_lock(&lock);
> read data; (load operation)
> mutex_unlock(&lock);

Yes, it looks like we can screw things up in the uncontended case (where
nobody blocks on the mutex). We could add an smp_mb after the lock operation
and another one before the unlock, but I'm tempted just to use
asm-generic/mutex-dec.h instead. The latter approach will subtly change the
current behaviour, so I'll post a patch when I'm happy with it.

Curious: did you find this by inspection or did you observe it going wrong?

Cheers,

Will
