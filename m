From: rbairva@gmail.com (rd bairva)
Date: Fri, 8 Jul 2011 17:08:38 +0530
Subject: ARM cortex A9 performance issue
In-Reply-To: <20110707152740.GG2486@arm.com>
References: <CAE_nTV4VgcNB0gc64zEPEfHp-hnDBsw6QsM=GqEObXAwzMTzTA@mail.gmail.com>
	<20110707152740.GG2486@arm.com>
Message-ID: <CAE_nTV7PuEJx0WJKCtbGU-4HjEBzFxPRmPLue1toktS27Htbzg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Now i have modified a source a little bit. Now I am doing a pingpong
using msgsnd and msgrcv. using this I am getting 40000req/sec and 55%
CPU usage.
In another version I have taken the same lock in both the processes to
ensure same thread is unlocking the mutex. But CPU usage is 100%.
Shouldn't be the behaviour 50%.

algo
msgsnd/msgrcv version.

Process1
shared memory counter++
msgsnd1
msgrcv 2

Process2
msgrcv 1
shared memory counter--
msgsnd2

Mutex version:
Process 1

mutex1
c++
unlock_mutex1

Process 2
mutex1
c++
unlock_mutex1


Regards,
Ramdayal


On Thu, Jul 7, 2011 at 8:57 PM, Dave Martin <dave.martin@linaro.org> wrote:
> On Thu, Jul 07, 2011 at 02:48:05PM +0530, rd bairva wrote:
>> Hi,
>>
>> We are trying to benchmark ARM cortex A9 dual core behavior with
>> respect to single core
>> performance and also measuring it with respect to x86 dual core/single core.
>> Please find attached with the mail is c app which we are using for benchmarking.
>>
>> Simple overview of C application:
>> - It creates a shared memory area using shm_open().
>> ? in this shm area, it declares 2 Process shared pthread mutex, lets say L1, L2.
>> - then it forks to create a server_task and client task.
>> - server_task takes L1 lock, touches a shm area, unlock L2, in a loop.
>> - client_task takes L2 lock, touches a shm area, unlock L1, in a loop.
>> - This loop runs for N number of times that we measure.
>
> The behaviour of pthread_mutex_unlock is unspecified if an attempt is made
> to ulock a mutex from a thread which doesn't currently own that mutex.
> You probably need to re-code your test to avoid this incorrect use of
> the ABI before an interpretation can be placed on the results.
>
> See pthread_mutexattr_init(3) for details.
>
>
>
> Some people have been reported issues related to ?process shared mutexes
> on ARM recently:
>
> https://bugs.launchpad.net/ubuntu/+source/apr/+bug/604753
>
> I'm not sure of the current status of that though, and I don't know
> whether it would affect your test or not.
>
> Cheers
> ---Dave
>
>>
>> Here are the results for N/sec for different CPUs.
>>
>> Platform ? ? ? ? ? ? ?Up cores ? ? ? ? ? ? ?req/sec ? ? ? ? ? ? ? ?cpuload
>> Cortexa9 ? ? ? ? ? ? ? ? ? ?2 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?~44000
>> ? ? ? ? ? ? 100%
>> Cortexa9 ? ? ? ? ? ? ? ? ? ?1 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?~18000
>> ? ? ? ? ? ? 100%
>> X86 ? ? ? ? ? ? ? ? ? ? ? ? ? ?2 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?~64000
>> ? ? ? ? ? ? ? ?35%
>> X86 ? ? ? ? ? ? ? ? ? ? ? ? ? ?1 ? ? ? ? ? ? ? ? ? ? ? ? ? ? ?~458886
>> ? ? ? ? ? ? ?100% ? ? (1 cpu down by sysfs)
>>
>> we are not able to understand the results.
>> - why for coretx A9 both dual/single core we are getting 100% cpu usage.
>> - why in case of x86, N/sec is very high for single core than dual core.
>> - why single core N/s is 1/3 in case of CortexA9.
>>
>> Thanks,
>> Ramdayal
>
>
>> _______________________________________________
>> linux-arm-kernel mailing list
>> linux-arm-kernel at lists.infradead.org
>> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
>
>
