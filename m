From: walken@google.com (Michel Lespinasse)
Date: Tue, 5 Mar 2013 08:32:14 -0800
Subject: [PATCH] lglock: add read-preference local-global rwlock
In-Reply-To: <51361540.3060603@cn.fujitsu.com>
References: <512C7A38.8060906@linux.vnet.ibm.com>
 <CACvQF51RvhM8XNqu3-1OTQ=cZUZ=pAX+_zx0a29+W67N1X+BgQ@mail.gmail.com>
 <512CC509.1050000@linux.vnet.ibm.com>
 <CACvQF50UgiqPpDk3HCmV86zKSf6tPjqr0bZowfPEOJs0g0r0MQ@mail.gmail.com>
 <512D0D67.9010609@linux.vnet.ibm.com>
 <CACvQF53ph2ixdM-otzetjM5cR+2kcZj6sckOp3TnzzA_x-EZ8w@mail.gmail.com>
 <512E7879.20109@linux.vnet.ibm.com> <5130E8E2.50206@cn.fujitsu.com>
 <20130301182854.GA3631@redhat.com>
 <CANN689HEW=b5S93J27p+rBX-5m7jkW4FER=eHDCp7OgMaTWLPw@mail.gmail.com>
 <20130302170656.GB29769@redhat.com>
 <51361540.3060603@cn.fujitsu.com>
Message-ID: <CANN689EKsSZpq-oVPL3_y+ReT+vbz5wPbOs8iz8YzS_Wo-FboQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Mar 5, 2013 at 7:54 AM, Lai Jiangshan <laijs@cn.fujitsu.com> wrote:
> On 03/03/13 01:06, Oleg Nesterov wrote:
>> On 03/02, Michel Lespinasse wrote:
>>>
>>> My version would be slower if it needs to take the
>>> slow path in a reentrant way, but I'm not sure it matters either :)
>>
>> I'd say, this doesn't matter at all, simply because this can only happen
>> if we race with the active writer.
>>
>
> It can also happen when interrupted. (still very rarely)
>
> arch_spin_trylock()
>         ------->interrupted,
>                 __this_cpu_read() returns 0.
>                 arch_spin_trylock() fails
>                 slowpath, any nested will be slowpath too.
>                 ...
>                 ..._read_unlock()
>         <-------interrupt
> __this_cpu_inc()
> ....

Yes (and I think this is actually the most likely way for it to happen).

We do need this to work correctly, but I don't expect we need it to be fast.
(could be wrong, this is only my intuition)

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
