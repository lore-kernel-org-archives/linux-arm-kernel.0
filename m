From: will.deacon@arm.com (Will Deacon)
Date: Wed, 8 Aug 2018 16:44:48 +0100
Subject: [PATCH] ARM: spinlock: avoid exclusive accesses on
 unlock()path
In-Reply-To: <tencent_5E0B19C04FA531B834205F9F@qq.com>
References: <tencent_5E0B19C04FA531B834205F9F@qq.com>
Message-ID: <20180808154448.GB31006@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Aug 08, 2018 at 08:30:28AM +0800, ??? wrote:
> On 8 Aug 2018, will.deacon wrote:
> 
> >On Tue, Aug 07, 2018 at 09:59:13AM +0800, ??? wrote:
> >> while one cpu is doing arch_spin_unlock,another cpu doing arch_spin_lock
> > >the first cpu's
> > >lock->tickets.owner++;
> > >may be over writed by the second's
> > >strex %2, %1, [%3]\n
> > >so the owner filed doesn't get increased.
> 
> >I don't see how this can happen. If the unlocker writes to the owner field
> >in-between the locker's LDXR/STXR pair (which is the only way the harmful
> >overwrite could occur as far as I can tell), then the STXR will fail and not
> >update memory.
> 
> >Are you actually seeing a problem here?
> 
> In DDI0406C_C_arm_architecture_reference_manual.pdf A3-117, It says after
> normal Store operation,  the monitor maybe in Exclusive Access or Open Access
> which is implementation defined.

You're looking at the section describing non-shareable memory. If you scroll
down to A3-119, you can see that a store to the tagged address from a
different CPU will transition the monitor to the open state.

Will
