From: julien.thierry@arm.com (Julien Thierry)
Date: Fri, 23 Nov 2018 09:27:02 +0000
Subject: Sleeping in user_access section
Message-ID: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I made an attempt at implementing the 
user_access_begin()/user_access_end() macros along with the 
get/put_user_unsafe() for arm64 by toggling the status of PAN (more or 
less similar to x86's STAC/CTAC).

With a small mistake in my patch, we realized that directly calling 
function that could reschedule while in a user_access section could lead to:

- scheduling another task keeping the user_access status enabled despite 
the task never calling user_access_begin()

- when re-scheduling the task that was mid user_access section, 
user_access would be disabled and the task would fault on the next 
get/put_user_unsafe.


This is because __switch_to does not alter the user_access status when 
switching from next to prev (at least on arm64 we currently don't, and 
by looking at the x86 code I don't think this is done either).


 From my understanding, this is not an issue when the task in 
user_access mode gets scheduled out/in as a result of an interrupt as 
PAN and EFLAGS.AC get saved/restore on exception entry/exit (at least I 
know it is the case for PAN, I am less sure for the x86 side).


So, the question is, should __switch_to take care of the user_access 
status when scheduling new tasks? Or should there be a restriction about 
scheduling out a task with user_access mode enabled and maybe add a 
warning if we can detect this?

(Or did we miss something and this is not an issue on x86?)

Thanks,

-- 
Julien Thierry
