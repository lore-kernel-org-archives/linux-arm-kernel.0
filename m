From: will.deacon@arm.com (Will Deacon)
Date: Tue, 7 Aug 2018 17:56:39 +0100
Subject: [PATCH] ARM: spinlock: avoid exclusive accesses on unlock()
 path
In-Reply-To: <tencent_7ECB5CA838202151603A2FF6@qq.com>
References: <tencent_76D135D5D379BDAB2A2436393315C6E4E807@qq.com>
 <tencent_6BF9DD7B77B1CAA95FBAEE73@qq.com>
 <tencent_7ECB5CA838202151603A2FF6@qq.com>
Message-ID: <20180807165638.GB21809@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Aug 07, 2018 at 09:59:13AM +0800, ??? wrote:
> while one cpu is doing arch_spin_unlock,another cpu doing arch_spin_lock
> the first cpu's
> lock->tickets.owner++;
> may be over writed by the second's 
> strex	%2, %1, [%3]\n
> so the owner filed doesn't get increased. 

I don't see how this can happen. If the unlocker writes to the owner field
in-between the locker's LDXR/STXR pair (which is the only way the harmful
overwrite could occur as far as I can tell), then the STXR will fail and not
update memory.

Are you actually seeing a problem here?

Will
