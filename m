From: arnd@arndb.de (Arnd Bergmann)
Date: Thu, 15 Oct 2015 14:46:16 +0200
Subject: [PATCH] arm64: ftrace: function_graph: dump real return addr in
 call trace
In-Reply-To: <1444911155-17480-1-git-send-email-huawei.libin@huawei.com>
References: <1444911155-17480-1-git-send-email-huawei.libin@huawei.com>
Message-ID: <6277407.jveniKQDxt@wuerfel>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thursday 15 October 2015 20:12:35 Li Bin wrote:
> 
> +#ifdef CONFIG_FUNCTION_GRAPH_TRACER
> +static void print_ftrace_graph_addr(unsigned long addr,
> +                                       struct task_struct *tsk,
> +                                       unsigned long sp, int *graph)
> +{
> +       unsigned long ret_addr;
> +       int index = tsk->curr_ret_stack;
> +
> +       if (addr != ((unsigned long)return_to_handler - 4))
> +               return;
> +
> +       if (!tsk->ret_stack || index < *graph)
> 

I think it would be nicer to remove the #ifdef and write this as

static void print_ftrace_graph_addr(unsigned long addr,
                                    struct task_struct *tsk,
                                    unsigned long sp, int *graph)
{
       unsigned long ret_addr;
       int index = tsk->curr_ret_stack;

       if (!IS_ENABLED(CONFIG_FUNCTION_GRAPH_TRACER))
		return;

       if (addr != ((unsigned long)return_to_handler - 4))
               return;
