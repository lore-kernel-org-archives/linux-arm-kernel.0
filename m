From: a.p.zijlstra@chello.nl (Peter Zijlstra)
Date: Sat, 24 Mar 2012 13:43:41 +0100
Subject: [PATCH 01/10] cpu: Introduce clear_tasks_mm_cpumask() helper
In-Reply-To: <20120324102751.GA29067@lizard>
References: <20120324102609.GA28356@lizard> <20120324102751.GA29067@lizard>
Message-ID: <1332593021.16159.27.camel@twins>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, 2012-03-24 at 14:27 +0400, Anton Vorontsov wrote:
> +void clear_tasks_mm_cpumask(int cpu)
> +{
> +       struct task_struct *p;
> +
> +       read_lock(&tasklist_lock);
> +       for_each_process(p) {
> +               struct task_struct *t;
> +
> +               t = find_lock_task_mm(p);
> +               if (!t)
> +                       continue;
> +               cpumask_clear_cpu(cpu, mm_cpumask(t->mm));
> +               task_unlock(t);
> +       }
> +       read_unlock(&tasklist_lock);
> +} 

Why bother with the tasklist_lock at all anymore, afaict you could use
rcu_read_lock() here. This all is called after the cpu is taken down and
marked offline, so its not like new tasks will ever get this cpu set in
their mm mask.
