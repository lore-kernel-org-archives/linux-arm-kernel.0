From: dhowells@redhat.com (David Howells)
Date: Mon, 11 Feb 2013 12:41:31 +0000
Subject: [PATCH v5 01/45] percpu_rwlock: Introduce the global
 reader-writer lock backend
In-Reply-To: <20130122073315.13822.27093.stgit@srivatsabhat.in.ibm.com>
References: <20130122073315.13822.27093.stgit@srivatsabhat.in.ibm.com>
 <20130122073210.13822.50434.stgit@srivatsabhat.in.ibm.com>
Message-ID: <30708.1360586491@warthog.procyon.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com> wrote:

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

The lock order on CPU 0 is unsafe if CPU2 can do:

	write_lock(&my_rwlock);
	spin_lock(&random_lock);

and on CPU 1 if CPU2 can do:

	spin_lock(&random_lock);
	write_lock(&my_rwlock);

I presume you were specifically excluding these situations?

David
