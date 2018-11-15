From: ravi.bangoria@linux.ibm.com (Ravi Bangoria)
Date: Thu, 15 Nov 2018 09:36:42 +0530
Subject: [PATCH] Uprobes: Fix kernel oops with delayed_uprobe_remove()
In-Reply-To: <20181114160600.GD13885@redhat.com>
References: <20181114081921.26484-1-ravi.bangoria@linux.ibm.com>
 <20181114160600.GD13885@redhat.com>
Message-ID: <556c2aa5-550d-d96f-7ed2-549d8f3d803b@linux.ibm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Oleg,

On 11/14/18 9:36 PM, Oleg Nesterov wrote:
> On 11/14, Ravi Bangoria wrote:
>>
>> syzbot reported a kernel crash with delayed_uprobe_remove():
>>   https://lkml.org/lkml/2018/11/1/1244
>>
>> Backtrace mentioned in the link points to a race between process
>> exit and uprobe_unregister(). Fix it by locking delayed_uprobe_lock
>> before calling delayed_uprobe_remove() from put_uprobe().
> 
> The patch looks good to me, but could you update the changelog?
> 
> Please explain that the exiting task calls uprobe_clear_state() which
> can race with delayed_uprobe_remove(). IIUC this is the only problem
> solved by this patch, right?

Right. Is this better:

There could be a race between task exit and probe unregister:

  exit_mm()
  mmput()
  __mmput()                     uprobe_unregister()
  uprobe_clear_state()          put_uprobe()
  delayed_uprobe_remove()       delayed_uprobe_remove()

put_uprobe() is calling delayed_uprobe_remove() without taking
delayed_uprobe_lock and thus the race sometimes results in a
kernel crash. Fix this by taking delayed_uprobe_lock before
calling delayed_uprobe_remove() from put_uprobe().

Detailed crash log can be found at:
  https://lkml.org/lkml/2018/11/1/1244
