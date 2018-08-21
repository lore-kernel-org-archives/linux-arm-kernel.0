From: liu.song.a23@gmail.com (Song Liu)
Date: Tue, 21 Aug 2018 13:46:22 -0700
Subject: [PATCH v9 3/4] trace_uprobe/sdt: Prevent multiple reference
 counter for same uprobe
In-Reply-To: <20180820044250.11659-4-ravi.bangoria@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <20180820044250.11659-4-ravi.bangoria@linux.ibm.com>
Message-ID: <CAPhsuW4hZv7cdF37aAUyfMR5e_Wb-25Drzjg7=MNNf8Gb9dOMQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Aug 19, 2018 at 9:42 PM, Ravi Bangoria
<ravi.bangoria@linux.ibm.com> wrote:
> We assume to have only one reference counter for one uprobe.
> Don't allow user to add multiple trace_uprobe entries having
> same inode+offset but different reference counter.
>
> Ex,
>   # echo "p:sdt_tick/loop2 /home/ravi/tick:0x6e4(0x10036)" > uprobe_events
>   # echo "p:sdt_tick/loop2_1 /home/ravi/tick:0x6e4(0xfffff)" >> uprobe_events
>   bash: echo: write error: Invalid argument
>
>   # dmesg
>   trace_kprobe: Reference counter offset mismatch.
>
> There is one exception though:
> When user is trying to replace the old entry with the new
> one, we allow this if the new entry does not conflict with
> any other existing entries.
>
> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
> Reviewed-by: Song Liu <songliubraving@fb.com>

Reviewed-and-tested-by: Song Liu <songliubraving@fb.com>

> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> ---
>  kernel/trace/trace_uprobe.c | 37 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 35 insertions(+), 2 deletions(-)
>
> diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
> index a7ef6c4ca16e..21d9fffaa096 100644
> --- a/kernel/trace/trace_uprobe.c
> +++ b/kernel/trace/trace_uprobe.c
> @@ -324,6 +324,35 @@ static int unregister_trace_uprobe(struct trace_uprobe *tu)
>         return 0;
>  }
>
> +/*
> + * Uprobe with multiple reference counter is not allowed. i.e.
> + * If inode and offset matches, reference counter offset *must*
> + * match as well. Though, there is one exception: If user is
> + * replacing old trace_uprobe with new one(same group/event),
> + * then we allow same uprobe with new reference counter as far
> + * as the new one does not conflict with any other existing
> + * ones.
> + */
> +static struct trace_uprobe *find_old_trace_uprobe(struct trace_uprobe *new)
> +{
> +       struct trace_uprobe *tmp, *old = NULL;
> +       struct inode *new_inode = d_real_inode(new->path.dentry);
> +
> +       old = find_probe_event(trace_event_name(&new->tp.call),
> +                               new->tp.call.class->system);
> +
> +       list_for_each_entry(tmp, &uprobe_list, list) {
> +               if ((old ? old != tmp : true) &&
> +                   new_inode == d_real_inode(tmp->path.dentry) &&
> +                   new->offset == tmp->offset &&
> +                   new->ref_ctr_offset != tmp->ref_ctr_offset) {
> +                       pr_warn("Reference counter offset mismatch.");
> +                       return ERR_PTR(-EINVAL);
> +               }
> +       }
> +       return old;
> +}
> +
>  /* Register a trace_uprobe and probe_event */
>  static int register_trace_uprobe(struct trace_uprobe *tu)
>  {
> @@ -333,8 +362,12 @@ static int register_trace_uprobe(struct trace_uprobe *tu)
>         mutex_lock(&uprobe_lock);
>
>         /* register as an event */
> -       old_tu = find_probe_event(trace_event_name(&tu->tp.call),
> -                       tu->tp.call.class->system);
> +       old_tu = find_old_trace_uprobe(tu);
> +       if (IS_ERR(old_tu)) {
> +               ret = PTR_ERR(old_tu);
> +               goto end;
> +       }
> +
>         if (old_tu) {
>                 /* delete old event */
>                 ret = unregister_trace_uprobe(old_tu);
> --
> 2.14.4
>
