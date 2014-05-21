From: raghupv30@gmail.com (Raghu Pv)
Date: Wed, 21 May 2014 14:40:16 +0100
Subject: CLONE from pthread_create fails with ERESTARTNOINTR and application
 crashes
Message-ID: <CAGJAg9EHSgOg3trryA5Zb5ms8pfTX6Y7DF4s-mEP6YZmD8twVw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Overview:



CLONE from pthread_create fails with ERESTARTNOINTR and application crashes



Steps to reproduce:



Executing a multithreaded application that creates and terminates
threads and also there a lot of signals



If a signal arrives during execution of clone(), clone is returning
ERESTARTNOINTR to userspace.



We see the following implementation that sets ERESTARTNOINTR:



        /*

         * Process group and session signals need to be delivered to just the

         * parent before the fork or both the parent and the child after the

         * fork. Restart if a signal comes in before we add the new process to

         * it's process group.

         * A fatal signal pending means that current will exit, so the new

         * thread can't slip out of an OOM kill (or normal SIGKILL).

         */

        recalc_sigpending();

        if (signal_pending(current)) {

                spin_unlock(&current->sighand->siglock);

                write_unlock_irq(&tasklist_lock);

                retval = -ERESTARTNOINTR;

                goto bad_fork_cleanup_namespace;

        }





Leaking ERESTARTNOINTR to userspace is a big concern because this a
kernel internal error code.



Immediately after that the application crashes.



Actual result: Application crashes



Expected Result: Application should not crash and clone system call
should restart if clone is previously interrupted by a signal.
