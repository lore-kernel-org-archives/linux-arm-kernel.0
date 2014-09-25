From: khilman@kernel.org (Kevin Hilman)
Date: Thu, 25 Sep 2014 15:59:03 -0700
Subject: [PATCH v2] soc: qcom: do not disable the iface clock in probe
In-Reply-To: <5422E390.9060802@linaro.org> (Srinivas Kandagatla's message of
 "Wed, 24 Sep 2014 16:30:24 +0100")
References: <1411500054-13600-1-git-send-email-srinivas.kandagatla@linaro.org>
 <7hbnq5m4a5.fsf@deeprootsystems.com> <5422E390.9060802@linaro.org>
Message-ID: <7hfvff8fyg.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:

> On 24/09/14 16:22, Kevin Hilman wrote:
>> Srinivas Kandagatla <srinivas.kandagatla@linaro.org> writes:
>>
>>> since commit 31964ffebbb9 ("tty: serial: msm: Remove direct access to GSBI")'
>>> serial hangs if earlyprintk are enabled.
>>>
>>> This hang is noticed only when the GSBI driver is probed and all the
>>> earlyprintks before gsbi probe are seen on the console.
>>> The reason why it hangs is because GSBI driver disables hclk in its
>>> probe function without realizing that the serial IP might be in use by
>>> a bootconsole. As gsbi driver disables the clock in probe the
>>> bootconsole locks up.
>>
>>> Turning off hclk's could be dangerous if there are system components
>>> like earlyprintk using the hclk.
>>
>> This seems rather fragile.  Isn't the right fix for these other
>> components to use the clk api to ensure the clock does not get enabled?
> Here we are depending on the bootloader to setup the clocks.
>
> Am not sure if we can really use clk apis at that early stage of bootstrap.

Not that early, but all that matters is that you clk_enable() sometime
before the GSBI driver calls clk_disable().

If the clocks are always enabled by the bootloader, the platforms clock
driver might check for those and ensure they are enabled, so that linux
is aware of it, and bugs like this one are avoided.

IMO, clock enable/disable shuffling in the GSBI driver to avoid UART
console problems is just papering over a bug that's waiting to pop up
elsewhere.

Kevin
