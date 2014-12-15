From: k.kozlowski@samsung.com (Krzysztof Kozlowski)
Date: Mon, 15 Dec 2014 15:53:06 +0100
Subject: [RFC PATCHv3 1/7] devfreq: event: Add new devfreq_event class to
 provide basic data for devfreq governor
In-Reply-To: <1418372852-12454-2-git-send-email-cw00.choi@samsung.com>
References: <1418372852-12454-1-git-send-email-cw00.choi@samsung.com>
 <1418372852-12454-2-git-send-email-cw00.choi@samsung.com>
Message-ID: <1418655186.20866.5.camel@AMDC1943>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On pi?, 2014-12-12 at 17:27 +0900, Chanwoo Choi wrote:
> This patch add new devfreq_event class for devfreq_event device which provide
> raw data (e.g., memory bus utilization/GPU utilization). This raw data from
> devfreq_event data would be used for the governor of devfreq subsystem.
> - devfreq_event device : Provide raw data for governor of existing devfreq device
> - devfreq device       : Monitor device state and change frequency/voltage of device
>                          using the raw data from devfreq_event device
> 
> The devfreq subsystem support generic DVFS(Dynamic Voltage/Frequency Scaling)
> for Non-CPU Devices. The devfreq device would dertermine current device state
> using various governor (e.g., ondemand, performance, powersave). After completed
> determination of system state, devfreq device would change the frequency/voltage
> of devfreq device according to the result of governor.
> 
> But, devfreq governor must need basic data which indicates current device state.
> Existing devfreq subsystem only consider devfreq device which check current system
> state and determine proper system state using basic data. There is no subsystem
> for device providing basic data to devfreq device.
> 
> The devfreq subsystem must need devfreq_event device(data-provider device) for
> existing devfreq device. So, this patch add new devfreq_event class for
> devfreq_event device which read various basic data(e.g, memory bus utilization,
> GPU utilization) and provide measured data to existing devfreq device through
> standard APIs of devfreq_event class.
> 
> The following description explains the feature of two kind of devfreq class:
> - devfreq class (existing)
>  : devfreq consumer device use raw data from devfreq_event device for
>    determining proper current system state and change voltage/frequency
>    dynamically using various governors.
> 
> - devfreq_event class (new)
>  : Provide measured raw data to devfreq device for governor
> 
> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>
> Cc: Kyungmin Park <kyungmin.park@samsung.com>
> Signed-off-by: Chanwoo Choi <cw00.choi@samsung.com>

[...]

> +/**
> + * devfreq_event_get_event() - Get event and total_event from devfreq-event dev.
> + * @edev	: the devfreq-event device
> + *
> + * Note that this function get the calculated event data from devfreq-event dev
> + * after stoping the progress of whole sequence of devfreq-event dev. Return
> + * current event data and total_event should be stored in second parameter
> + * (total_event).
> + */
> +u64 devfreq_event_get_event(struct devfreq_event_dev *edev, u64 *total_event)
> +{

I think this function should return int (0 for success, negative
otherwise) and store the "event" under pointer passed as argument.
Why? Because:
1. error conditions are indicated with 'return 0' but should be 'return
-EINVAL'
2. Exynos-ppmu driver returns -EINVAL.
Checking for error conditions is in such case more complex than it
should.


Best regards,
Krzysztof
