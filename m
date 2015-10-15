From: will.deacon@arm.com (Will Deacon)
Date: Thu, 15 Oct 2015 13:51:33 +0100
Subject: [PATCH] arm64: ftrace: function_graph: dump real return addr in
 call trace
In-Reply-To: <6277407.jveniKQDxt@wuerfel>
References: <1444911155-17480-1-git-send-email-huawei.libin@huawei.com>
 <6277407.jveniKQDxt@wuerfel>
Message-ID: <20151015125133.GA29301@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 15, 2015 at 02:46:16PM +0200, Arnd Bergmann wrote:
> On Thursday 15 October 2015 20:12:35 Li Bin wrote:
> > 
> > +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> > +static void print_ftrace_graph_addr(unsigned long addr,
> > +                                       struct task_struct *tsk,
> > +                                       unsigned long sp, int *graph)
> > +{
> > +       unsigned long ret_addr;
> > +       int index = tsk->curr_ret_stack;
> > +
> > +       if (addr != ((unsigned long)return_to_handler - 4))
> > +               return;
> > +
> > +       if (!tsk->ret_stack || index < *graph)
> > 
> 
> I think it would be nicer to remove the #ifdef and write this as
> 
> static void print_ftrace_graph_addr(unsigned long addr,
>                                     struct task_struct *tsk,
>                                     unsigned long sp, int *graph)
> {
>        unsigned long ret_addr;
>        int index = tsk->curr_ret_stack;
> 
>        if (!IS_ENABLED(CONFIG_FUNCTION_GRAPH_TRACER))
> 		return;
> 
>        if (addr != ((unsigned long)return_to_handler - 4))
>                return;

Is this the same old problem caused by e306dfd06fcb ("ARM64: unwind: Fix
PC calculation")? I've said previously that I'm happy to revert that if
we're the only architecture with this behaviour, but Akashi resisted
because there are other issues with ftrace that he was hoping to address
and they would resolve this too.

Will
