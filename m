From: hpa@zytor.com (hpa at zytor.com)
Date: Fri, 23 Nov 2018 01:57:12 -0800
Subject: Sleeping in user_access section
In-Reply-To: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
References: <3e881ee6-0ff6-b8b6-0633-3d4a7743411d@arm.com>
Message-ID: <5B3B6AF9-9D8C-4577-905E-D407A5E7D0E3@zytor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On November 23, 2018 1:27:02 AM PST, Julien Thierry <julien.thierry@arm.com> wrote:
>Hi,
>
>I made an attempt at implementing the 
>user_access_begin()/user_access_end() macros along with the 
>get/put_user_unsafe() for arm64 by toggling the status of PAN (more or 
>less similar to x86's STAC/CTAC).
>
>With a small mistake in my patch, we realized that directly calling 
>function that could reschedule while in a user_access section could
>lead to:
>
>- scheduling another task keeping the user_access status enabled
>despite 
>the task never calling user_access_begin()
>
>- when re-scheduling the task that was mid user_access section, 
>user_access would be disabled and the task would fault on the next 
>get/put_user_unsafe.
>
>
>This is because __switch_to does not alter the user_access status when 
>switching from next to prev (at least on arm64 we currently don't, and 
>by looking at the x86 code I don't think this is done either).
>
>
> From my understanding, this is not an issue when the task in 
>user_access mode gets scheduled out/in as a result of an interrupt as 
>PAN and EFLAGS.AC get saved/restore on exception entry/exit (at least I
>
>know it is the case for PAN, I am less sure for the x86 side).
>
>
>So, the question is, should __switch_to take care of the user_access 
>status when scheduling new tasks? Or should there be a restriction
>about 
>scheduling out a task with user_access mode enabled and maybe add a 
>warning if we can detect this?
>
>(Or did we miss something and this is not an issue on x86?)
>
>Thanks,

You should never call a sleeping function from a user_access section. It is intended for very limited regions.
-- 
Sent from my Android device with K-9 Mail. Please excuse my brevity.
