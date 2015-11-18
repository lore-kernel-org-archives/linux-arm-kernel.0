From: schwab@suse.de (Andreas Schwab)
Date: Wed, 18 Nov 2015 09:25:40 +0100
Subject: [PATCH v6 15/19] arm64: ilp32: force IPC_64 in msgctl, shmctl,
 semctl
In-Reply-To: <26387039.NNJ6EnRrv8@wuerfel> (Arnd Bergmann's message of "Tue,
 17 Nov 2015 23:07:03 +0100")
References: <1447795019-30176-1-git-send-email-ynorov@caviumnetworks.com>
 <1447795019-30176-16-git-send-email-ynorov@caviumnetworks.com>
 <26387039.NNJ6EnRrv8@wuerfel>
Message-ID: <mvmoaersohn.fsf@hawking.suse.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Wednesday 18 November 2015 00:16:55 Yury Norov wrote:
>> 
>> +/* IPC_64 */
>> +asmlinkage long ilp32_sys_msgctl(int first, int second, void __user *uptr)
>> +{
>> +       return compat_sys_msgctl(first, second | IPC_64, uptr);
>> +}
>> +#define compat_sys_msgctl              ilp32_sys_msgctl
>> +
>> +asmlinkage long ilp32_sys_shmctl(int first, int second, void __user *uptr)
>> +{
>> +       return compat_sys_shmctl(first, second | IPC_64, uptr);
>> +}
>> +#define compat_sys_shmctl              ilp32_sys_shmctl
>> +
>> +asmlinkage long ilp32_sys_semctl(int first, int second, int third, int arg)
>> +{
>> +       return compat_sys_semctl(first, second, third | IPC_64, arg);
>> +}
>> +#define compat_sys_semctl      ilp32_sys_semctl
>> 
>
> I wonder if this would be any simpler by changing compat_ipc_parse_version()

This cries for a generic solution.  Other archs migrating to separate
ipc syscalls will want to avoid the whole IPC_64 business for them, even
if they need to retain [compat_]ipc_parse_version for sys_ipc
compatibility.

Andreas.

-- 
Andreas Schwab, SUSE Labs, schwab at suse.de
GPG Key fingerprint = 0196 BAD8 1CE9 1970 F4BE  1748 E4D4 88E3 0EEA B9D7
"And now for something completely different."
