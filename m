From: rostedt@goodmis.org (Steven Rostedt)
Date: Tue, 22 Jan 2013 14:32:32 -0500
Subject: [PATCH v5 01/45] percpu_rwlock: Introduce the global
 reader-writer lock backend
In-Reply-To: <20130122073315.13822.27093.stgit@srivatsabhat.in.ibm.com>
References: <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
 <20130122073315.13822.27093.stgit@srivatsabhat.in.ibm.com>
Message-ID: <1358883152.21576.55.camel@gandalf.local.home>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-01-22 at 13:03 +0530, Srivatsa S. Bhat wrote:
> A straight-forward (and obvious) algorithm to implement Per-CPU Reader-Writer
> locks can also lead to too many deadlock possibilities which can make it very
> hard/impossible to use. This is explained in the example below, which helps
> justify the need for a different algorithm to implement flexible Per-CPU
> Reader-Writer locks.
> 
> We can use global rwlocks as shown below safely, without fear of deadlocks:
> 
> Readers:
> 
>          CPU 0                                CPU 1
>          ------                               ------
> 
> 1.    spin_lock(&random_lock);             read_lock(&my_rwlock);
> 
> 
> 2.    read_lock(&my_rwlock);               spin_lock(&random_lock);
> 
> 
> Writer:
> 
>          CPU 2:
>          ------
> 
>        write_lock(&my_rwlock);
> 

I thought global locks are now fair. That is, a reader will block if a
writer is waiting. Hence, the above should deadlock on the current
rwlock_t types.

We need to fix those locations (or better yet, remove all rwlocks ;-)

-- Steve
