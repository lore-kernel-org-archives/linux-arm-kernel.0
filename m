From: oleg@redhat.com (Oleg Nesterov)
Date: Thu, 15 Nov 2018 13:43:18 +0100
Subject: [PATCH] Uprobes: Fix kernel oops with delayed_uprobe_remove()
In-Reply-To: <556c2aa5-550d-d96f-7ed2-549d8f3d803b@linux.ibm.com>
References: <20181114081921.26484-1-ravi.bangoria@linux.ibm.com>
 <20181114160600.GD13885@redhat.com>
 <556c2aa5-550d-d96f-7ed2-549d8f3d803b@linux.ibm.com>
Message-ID: <20181115124317.GA23272@redhat.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/15, Ravi Bangoria wrote:
>
> There could be a race between task exit and probe unregister:
>
>   exit_mm()
>   mmput()
>   __mmput()                     uprobe_unregister()
>   uprobe_clear_state()          put_uprobe()
>   delayed_uprobe_remove()       delayed_uprobe_remove()
>
> put_uprobe() is calling delayed_uprobe_remove() without taking
> delayed_uprobe_lock and thus the race sometimes results in a
> kernel crash. Fix this by taking delayed_uprobe_lock before
> calling delayed_uprobe_remove() from put_uprobe().
>
> Detailed crash log can be found at:
>   https://lkml.org/lkml/2018/11/1/1244

Thanks, looks good,

Oleg.
