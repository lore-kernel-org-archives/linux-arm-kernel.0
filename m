From: ccross@google.com (Colin Cross)
Date: Wed, 10 Apr 2013 11:22:37 -0700
Subject: [PATCH 05/18] cpuidle: make a single register function for all
In-Reply-To: <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
References: <1365603743-5618-1-git-send-email-daniel.lezcano@linaro.org>
 <1365603743-5618-6-git-send-email-daniel.lezcano@linaro.org>
Message-ID: <CAMbhsRSigxzDK3v20ARhXaXK11KL1xZRWkFOXA16YUZ=FtJN9g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 10, 2013 at 7:22 AM, Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
> The usual scheme to initialize a cpuidle driver on a SMP is:
>
>         cpuidle_register_driver(drv);
>         for_each_possible_cpu(cpu) {
>                 device = &per_cpu(cpuidle_dev, cpu);
>                 cpuidle_register_device(device);
>         }
>
> This code is duplicated in each cpuidle driver.
>
> On UP systems, it is done this way:
>
>         cpuidle_register_driver(drv);
>         device = &per_cpu(cpuidle_dev, cpu);
>         cpuidle_register_device(device);
>
> On UP, the macro 'for_each_cpu' does one iteration:
>
> #define for_each_cpu(cpu, mask)                 \
>         for ((cpu) = 0; (cpu) < 1; (cpu)++, (void)mask)
>
> Hence, the initialization loop is the same for UP than SMP.
>
> Beside, we saw different bugs / mis-initialization / return code unchecked in
> the different drivers, the code is duplicated including bugs. After fixing all
> these ones, it appears the initialization pattern is the same for everyone.
>
> Let's add a wrapper function doing this initialization with a cpumask parameter
> for the coupled idle states and use it for all the drivers.

Isn't this going to cause problems for big.LITTLE, which has two
independent sets of coupled cpus, and may even have different drivers
for the two types of cpu?
