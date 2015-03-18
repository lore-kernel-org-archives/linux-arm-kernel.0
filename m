From: viresh.kumar@linaro.org (Viresh Kumar)
Date: Wed, 18 Mar 2015 09:23:54 +0530
Subject: Is cpufreq-dt safe without regulator support?
In-Reply-To: <CAGb2v65z8hGdPqeW9DVa41PtMe6n8-=Gkw-YDu4mFiCbvvGT4A@mail.gmail.com>
References: <CAGb2v679W_NqG2d597tV9W-5ROZRTH-K542fofA_UbREDjfBhg@mail.gmail.com>
 <CAKohponnp3WgFO4nDwGwTYE9_mxzX5ttjA-Xi-9YJ7grjNcymQ@mail.gmail.com>
 <CAGb2v65z8hGdPqeW9DVa41PtMe6n8-=Gkw-YDu4mFiCbvvGT4A@mail.gmail.com>
Message-ID: <CAKohpomy6HkGYTm5KzjrWkk-RgipVkeHfoM1hLz9oAcZSWHcdg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 18 March 2015 at 07:10, wens Tsai <wens213@gmail.com> wrote:
> On Tue, Mar 17, 2015 at 4:47 PM, Viresh Kumar <viresh.kumar@linaro.org> wrote:
>> On 17 March 2015 at 13:15, wens Tsai <wens213@gmail.com> wrote:
>>> The sunxi platform added cpufreq support in 4.0.0-rc1 using
>>> the generic cpufreq-dt driver. One issue we've run into is
>>> the default OPPs we use include an overclocked/overvoltage
>>> setting.
>>
>> There is a feature for that in cpufreq, in case you don't know, "boost"..
>
> I do now. Though cpufreq-dt and the OPP bindings don't
> support this. Any chance the next version of OPP bindings will?

Yes, it is part of the new bindings already..

>>> If the cpu is missing a regulator supply phandle, or the
>>> kernel is built without regulators, cpufreq can increase
>>> the clock rate without the needed voltage increase.
>>
>> Right.
>>
>>> The former issue can be resolved by providing a dummy
>>> regulator with the default voltage, effectively disabling
>>> cpufreq.
>>
>> How ? CPUFreq will try to change both volt and freq. Volt
>> wouldn't change as its a dummy regulator, but freq would
>> still be changed..
>
> I suppose this is the desired behavior. I'm fine with it then.
>
>>> The latter is possible. Without regulator support built-in,
>>> even a correct, complete DTS can still fail. Should I just
>>> remove the offending OPP? Still that does not fix the
>>> problem when we actually do want overclocking.
>>>
>>> To summarize, should cpufreq-dt probe fail when regulator
>>> support isn't available? Should we differentiate between
>>
>> No. We can have regulator support enabled but no regulator
>> for a CPU. And so the current state of code looks fine.
>>
>>> not having a regulator phandle vs no regulator support?
>>
>> What I couldn't understand is, why would you miss the regulator
>> phandle in dts? Or not compile regulator support?
>
> I admit it is partly bad execution on my part. I added the OPPs
> to the .dtsi files, but only the regulators to a handful of boards
> that I have. All the other boards do not have a regulator phandle.
>
>> In case you want cpufreq-dt to be disabled if regulators aren't
>> compiled in, then what you should do is, don't create the platform
>> device required for probing cpufreq-dt driver.
>
> Thanks for the suggestion. I'll add if(IS_ENABLED()) around it.
> I can also check for the regulator phandle here.

I think the right thing to do is move the OPP bindings to the .dts
files instead and get rid of all the hacks you are planning to add.
