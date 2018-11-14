From: oleg@redhat.com (Oleg Nesterov)
Date: Wed, 14 Nov 2018 17:06:01 +0100
Subject: [PATCH] Uprobes: Fix kernel oops with delayed_uprobe_remove()
In-Reply-To: <20181114081921.26484-1-ravi.bangoria@linux.ibm.com>
References: <20181114081921.26484-1-ravi.bangoria@linux.ibm.com>
Message-ID: <20181114160600.GD13885@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/14, Ravi Bangoria wrote:
>
> syzbot reported a kernel crash with delayed_uprobe_remove():
>   https://lkml.org/lkml/2018/11/1/1244
>
> Backtrace mentioned in the link points to a race between process
> exit and uprobe_unregister(). Fix it by locking delayed_uprobe_lock
> before calling delayed_uprobe_remove() from put_uprobe().

The patch looks good to me, but could you update the changelog?

Please explain that the exiting task calls uprobe_clear_state() which
can race with delayed_uprobe_remove(). IIUC this is the only problem
solved by this patch, right?

Oleg.
