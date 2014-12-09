From: tixy@linaro.org (Jon Medhurst (Tixy))
Date: Tue, 09 Dec 2014 10:30:37 +0000
Subject: [PATCH v14 7/7] ARM: kprobes: enable OPTPROBES for ARM 32
In-Reply-To: <5486CB9F.6030804@hitachi.com>
References: <1418020040-68977-1-git-send-email-wangnan0@huawei.com>
 <1418020131-69375-1-git-send-email-wangnan0@huawei.com>
 <1418036666.3647.33.camel@linaro.org> <5485886E.2060303@huawei.com>
 <1418039451.3647.48.camel@linaro.org> <5486CB9F.6030804@hitachi.com>
Message-ID: <1418121037.3641.22.camel@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2014-12-09 at 19:14 +0900, Masami Hiramatsu wrote:
> (2014/12/08 20:50), Jon Medhurst (Tixy) wrote:> arch_optimize_kprobes is calling __arch_optimize_kprobes, which is
> > iterating over a list of probes and removing each one in turn, if this
> > is happening on multiple cpu's simultaneously, it's not clear to me that
> > such an operation is safe. list_del_init calls __list_del which does
> >
> > 	next->prev = prev;
> > 	prev->next = next;
> >
> > so what happens if another cpu is at the same time updating any of those
> > list entries? Without even fully analysing the code I can see that with
> > the fact that the list handling helpers have no memory barriers, that
> > the above two lines could be seen to execute in the reverse order, e.g.
> >
> > 	prev->next = next;
> > 	next->prev = prev;
> >
> > so another CPU could find and delete next before this one has finished
> > doing so. Would the list end up in a consistent state where no loops
> > develop and no probes are missed? I don't know the answer and a full
> > analysis would be complicated, but my gut feeling is that if a cpu can
> > observe the links in the list in an inconsistent state then only bad
> > things can result.
> 
> Just a comment, arch_optimize_kprobes() are only called under
> kprobe_mutex held. No concurrent update happens :)

Except in the case of the code I was commenting on which was using
stop_machine to make all cpu's simultaneously do the work of
arch_optimize_kprobes :-)

-- 
Tixy
