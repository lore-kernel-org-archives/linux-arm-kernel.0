From: ohad@wizery.com (Ohad Ben-Cohen)
Date: Mon, 21 Nov 2011 12:21:20 +0200
Subject: [PATCH] hwspinlock: core: support for TEGRA hardware spinlocks
In-Reply-To: <4EC205AC.4000202@nvidia.com>
References: <1321334342-3283-1-git-send-email-vwadekar@nvidia.com>
 <4EC205AC.4000202@nvidia.com>
Message-ID: <CAK=WgbYW_YH+b3xu1R+mDNPXj57mQ8547dzOJ7VUf2Y1wa8JnQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Varun,

On Tue, Nov 15, 2011 at 8:24 AM, Varun Wadekar <vwadekar@nvidia.com> wrote:
>> +The Tegra line of processors has a CPU and a COP similar to the OMAP processors.
>> +The Tegra SoC has a hardware block which arbitrates access to different hardware
>> +modules on the SoC between the CPU and the COP. The hardware spinlock block
>> +also has the capability to interrupt the caller when it has access to the
>> +requested hardware module. To facilitate SoCs like Tegra which do a lot more
>> +than just share data structures between the CPU and the COP, a new callback,
>> +int (*lock_timeout)(struct hwspinlock *lock, unsigned int to), has been added
>> +to struct hwspinlock_ops. The drivers which support functionality similar to
>> +the Tegra SoCs, will use lock_timeout to grant access to the hardware spinlock
>> +block on the SoCs. Such SoC drivers will not support all the apis exposed
>> +by the hwspinlock framework. More information below.
...
>> ? ? - lock a previously-assigned hwspinlock with a timeout limit (specified in
>> ? ? ? msecs). If the hwspinlock is already taken, the function will busy loop
>> ? ? ? waiting for it to be released, but give up when the timeout elapses.
>> - ? ? Upon a successful return from this function, preemption is disabled so
>> - ? ? the caller must not sleep, and is advised to release the hwspinlock as
>> + ? ? If the underlying hardware driver supports lock_timeout in it's ops structure
>> + ? ? then upon a successful return from this function, the caller is allowed
>> + ? ? to sleep since we do not disable premption or interrupts in this scenario.
>> + ? ? If not, upon a successful return from this function, preemption is disabled
>> + ? ? so the caller must not sleep, and is advised to release the hwspinlock as
>> ? ? ? soon as possible, in order to minimize remote cores polling on the
>> ? ? ? hardware interconnect.
>> ? ? ? Returns 0 when successful and an appropriate error code otherwise (most
...
>> @@ -182,6 +186,9 @@ int __hwspin_lock_timeout(struct hwspinlock *hwlock, unsigned int to,
>>
>> ? ? ? expire = msecs_to_jiffies(to) + jiffies;
>>
>> + ? ? if (hwlock->bank->ops->lock_timeout)
>> + ? ? ? ? ? ? return hwlock->bank->ops->lock_timeout(hwlock, expire);
>> +
>> ? ? ? for (;;) {
>> ? ? ? ? ? ? ? /* Try to take the hwspinlock */
>> ? ? ? ? ? ? ? ret = __hwspin_trylock(hwlock, mode, flags);

I'm afraid this makes it impossible to write generic drivers, as the
locking requirements of __hwspin_lock_timeout() depend now on the
underlying hardware: on OMAP it's a spinlock, and on Tegra it becomes
a semaphore. We should instead provide driver authors a well defined
API that is consistent across all systems.

In addition this proposal hides the entire ->lock_time()
implementation in the platform-specific driver, but we really only
want to hide the platform-specific differences, and keep the generic
parts in the core, so other platforms wouldn't have to duplicate it.

I think we should:
1. define a new 'struct hwsemaphore' object (or hwmutex to get shorter
api names..).
2. allow users to request either a hwspinlock or a hwsemaphore. it's
up to the drivers to request the synchronization primitive they need.
If it's not supported by the hardware, the request will fail.
3. add API to manipulate these new hwsemaphore objects (lock_timeout, unlock)
4. abstract only the bare minimum hw differences in the
platform-specific drivers, and keep generic parts in the core

This way drivers will always know whether a certain hardware
synchronization primitive allow them to sleep or not. It's much less
error prone too; a casual reader of the code will immediately tell the
difference between hwspin_lock and hwsemaphore_lock.

Eventually we will probably also have to rename the hwspinlock
subsystem to something like hwlock, but that's just a minor detail at
this point.

Thanks,
Ohad.
