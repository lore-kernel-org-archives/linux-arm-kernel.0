From: tomasz.figa@gmail.com (Tomasz Figa)
Date: Sun, 03 Aug 2014 00:16:13 +0200
Subject: [PATCH v3 1/7] ARM: l2c: Refactor the driver to use commit-like
 interface
In-Reply-To: <20140802220940.GW3705@n2100.arm.linux.org.uk>
References: <1405615142-21426-1-git-send-email-t.figa@samsung.com>
 <1405615142-21426-2-git-send-email-t.figa@samsung.com>
 <20140802220940.GW3705@n2100.arm.linux.org.uk>
Message-ID: <53DD632D.6070308@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 03.08.2014 00:09, Russell King - ARM Linux wrote:
> On Thu, Jul 17, 2014 at 06:38:56PM +0200, Tomasz Figa wrote:
>> Certain implementations of secure hypervisors (namely the one found on
>> Samsung Exynos-based boards) do not provide access to individual L2C
>> registers. This makes the .write_sec()-based interface insufficient and
>> provoking ugly hacks.
>>
>> This patch is first step to make the driver not rely on availability of
>> writes to individual registers. This is achieved by refactoring the
>> driver to use a commit-like operation scheme: all register values are
>> prepared first and stored in an instance of l2x0_regs struct and then a
>> single callback is responsible to flush those values to the hardware.
> 
> This isn't going to work very well...
> 
>> +static const struct l2c_init_data *l2x0_data;
> 
> So you keep a pointer to the init data...
> 
>> +static void l2c_resume(void)
>> +{
>> +	l2x0_data->enable(l2x0_base, l2x0_saved_regs.aux_ctrl,
>> +				l2x0_data->num_lock);
> 
> which you dereference at resume time...
> 
>>  static const struct l2c_init_data l2c210_data __initconst = {
> 
> but the structures which get assigned to the pointer are marked __initconst.

Good catch. The code was tested on Exynos which requires the cache to be
resumed from early assembly code and so I did not hit issues caused by this.

Proposed solution: kmemdup() in init, so that only used data remain in
memory and the structures can be kept __initconst.

Best regards,
Tomasz
