From: srikar@linux.vnet.ibm.com (Srikar Dronamraju)
Date: Wed, 22 Aug 2018 05:39:43 -0700
Subject: [PATCH v9 1/4] Uprobes: Support SDT markers having reference
 count (semaphore)
In-Reply-To: <20180820044250.11659-2-ravi.bangoria@linux.ibm.com>
References: <20180820044250.11659-1-ravi.bangoria@linux.ibm.com>
 <20180820044250.11659-2-ravi.bangoria@linux.ibm.com>
Message-ID: <20180822123943.GD2080@linux.vnet.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

* Ravi Bangoria <ravi.bangoria@linux.ibm.com> [2018-08-20 10:12:47]:

> Userspace Statically Defined Tracepoints[1] are dtrace style markers
> inside userspace applications. Applications like PostgreSQL, MySQL,
> Pthread, Perl, Python, Java, Ruby, Node.js, libvirt, QEMU, glib etc
> have these markers embedded in them. These markers are added by developer
> at important places in the code. Each marker source expands to a single
> nop instruction in the compiled code but there may be additional
> overhead for computing the marker arguments which expands to couple of
> instructions. In case the overhead is more, execution of it can be
> omitted by runtime if() condition when no one is tracing on the marker:
> 
>     if (reference_counter > 0) {
>         Execute marker instructions;
>     }
> 
> Default value of reference counter is 0. Tracer has to increment the
> reference counter before tracing on a marker and decrement it when
> done with the tracing.
> 
> Implement the reference counter logic in core uprobe. User will be
> able to use it from trace_uprobe as well as from kernel module. New
> trace_uprobe definition with reference counter will now be:
> 
>     <path>:<offset>[(ref_ctr_offset)]
> 
> where ref_ctr_offset is an optional field. For kernel module, new
> variant of uprobe_register() has been introduced:
> 
>     uprobe_register_refctr(inode, offset, ref_ctr_offset, consumer)
> 
> No new variant for uprobe_unregister() because it's assumed to have
> only one reference counter for one uprobe.
> 
> [1] https://sourceware.org/systemtap/wiki/UserSpaceProbeImplementation
> 
> Note: 'reference counter' is called as 'semaphore' in original Dtrace
> (or Systemtap, bcc and even in ELF) documentation and code. But the
> term 'semaphore' is misleading in this context. This is just a counter
> used to hold number of tracers tracing on a marker. This is not really
> used for any synchronization. So we are calling it a 'reference counter'
> in kernel / perf code.
> 


Acked-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>

> Signed-off-by: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
> Reviewed-by: Masami Hiramatsu <mhiramat@kernel.org>
> [Only trace_uprobe.c]
> Reviewed-by: Oleg Nesterov <oleg@redhat.com>
> ---
