From: bryan.wu@canonical.com (Bryan Wu)
Date: Mon, 30 Apr 2012 13:14:26 +0800
Subject: [PATCH 01/18] led-triggers: create a trigger for CPU activity
In-Reply-To: <1334704072.616.152.camel@ted>
References: <1334660025-20442-1-git-send-email-bryan.wu@canonical.com>
 <1334660025-20442-2-git-send-email-bryan.wu@canonical.com>
 <20120417155241.0f619a9a.akpm@linux-foundation.org>
 <1334704072.616.152.camel@ted>
Message-ID: <CAK5ve-L_o8tr1CGkv4doNQdSXyoqnWkk8jZmkE585Z++CZDAmQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Apr 18, 2012 at 7:07 AM, Richard Purdie
<richard.purdie@linuxfoundation.org> wrote:
> On Tue, 2012-04-17 at 15:52 -0700, Andrew Morton wrote:
>> On Tue, 17 Apr 2012 18:53:28 +0800
>> Bryan Wu <bryan.wu@canonical.com> wrote:
>> > + ? ?* ignores CPU hotplug, but after this CPU hotplug works
>> > + ? ?* fine with this trigger.
>> > + ? ?*/
>> > + ? for_each_possible_cpu(cpu) {
>> > + ? ? ? ? ? struct led_trigger *trig;
>> > + ? ? ? ? ? char *name = per_cpu(trig_name, cpu);
>> > + ? ? ? ? ? struct rw_semaphore *lock = &per_cpu(trig_lock, cpu);
>> > +
>> > + ? ? ? ? ? init_rwsem(lock);
>> > +
>> > + ? ? ? ? ? snprintf(name, MAX_NAME_LEN, "cpu%d", cpu);
>> > +
>> > + ? ? ? ? ? down_write(lock);
>> > + ? ? ? ? ? led_trigger_register_simple(name, &trig);
>>
>> OK, problem.
>>
>> led_trigger_register_simple() calls kzalloc() and
>> led_trigger_register(), both of which can fail.
>> led_trigger_register_simple() just returns void, failing to propagate
>> the error back. ?This is bad, and we (ie you ;)) should fix
>> led_trigger_register_simple() before proceeding to use it. ?If at all
>> possible. ?Please. ?Let us not propagate the badness further. ?Sorry.
>
> FWIW, this was really the way led_trigger_register_simple() was designed
> to work. It's original use was adding a trigger into other subsystems
> which didn't want a ton of LED code so it had the simple form:
>
> xxx = led_trigger_register_simple(name, &trig);
>

Richard, currently the led_trigger_register_simple() just return void,
so xxx here is wrong.

> where xxx could then be unregistered later equally simply and safely in
> one line. It didn't seem to make sense to pass the error around as it
> didn't really matter to the code it was being used in.
>
> I guess we could return an error pointer and check for that at
> unregister time in led_trigger_unregister_simple().
>

I also agree we don't need take care of failure in the caller as
led_trigger_register_simple() will take care of that.

>>
>> > + ? ? ? ? ? char *name = per_cpu(trig_name, cpu);
>> > +
>> > + ? ? ? ? ? led_trigger_unregister_simple(trig);
>>
>> And what happens if led_trigger_register_simple() had silently failed
>> to register this trigger? ?afacit, nothing: your code handles the
>> trig==NULL case OK. ?Still, we should be checking for those failures!
>
> FWIW, led_trigger_unregister_simple() will deal with NULL safely.
>

I will update my patches according to Andrew's comments shortly.

Thanks,
-- 
Bryan Wu <bryan.wu@canonical.com>
Kernel Developer ? ?+86.186-168-78255 Mobile
Canonical Ltd. ? ? ?www.canonical.com
Ubuntu - Linux for human beings | www.ubuntu.com
