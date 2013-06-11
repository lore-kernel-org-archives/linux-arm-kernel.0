From: andy.shevchenko@gmail.com (Andy Shevchenko)
Date: Tue, 11 Jun 2013 13:51:01 +0300
Subject: [PATCH 1/2] Initial support for Allwinner's Security ID fuses
In-Reply-To: <51B64877.4040908@schinagl.nl>
References: <1370185130-15332-1-git-send-email-oliver+list@schinagl.nl>
 <1370185130-15332-2-git-send-email-oliver+list@schinagl.nl>
 <CAHp75Vdqc9xiPBvQUB3Hfb4EBFUsoVxyuH8MK=9spJ4+rieoDQ@mail.gmail.com>
 <51B64877.4040908@schinagl.nl>
Message-ID: <CAHp75Vf8-JRjTHjoUDQPXA3LK3SQSeCzyroF=J4ZLmHMzy6jvw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Jun 11, 2013 at 12:43 AM, Oliver Schinagl
<oliver+list@schinagl.nl> wrote:
> On 06/06/13 21:16, Andy Shevchenko wrote:
>> On Sun, Jun 2, 2013 at 5:58 PM, Oliver Schinagl <oliver+list@schinagl.nl>
>> wrote:
>>> From: Oliver Schinagl <oliver@schinagl.nl>

>>> +       if (likely((SID_SIZE))) {
>>
>> Extra braces.
>> Use antipattern here.
>
> While I accidentally dropped the pointer here, sorry for the confusion, what
> is antipattern? I have asked around and nobody really knew.

In this case instead of doing...

if (likely(condition)) {
 do_smth();
}
do_very_few_ops();
return;

...better to do

if(unlikely(!condition)) {
 do_very_few_ops();
 return;
}

do_smth();
return;

It takes more lines of code, but increases readability a lot.

>>> +       if (unlikely(!pdev->dev.of_node)) {
>>> +               dev_err(dev, "No devicetree data available\n");
>>> +               ret = -EFAULT;
>>> +               goto exit;
>>
>>
>> Plain return here and in entire function where it applies.
>
> Why? I know there's conflicting preferences here. The general consensus
> seems, don't return mid function if you don't absolutely have to. Yet, you
> make it sound, just return wherever. I take it that really is just a
> preference? I think i see both constructs throughout the kernel. So one
> review prefers the one method, the next the other?

Usually it makes sense when you have to free resources or do something
like that. You have plain return statement under exit label.

>>> +       ret = device_create_bin_file(dev, &sid_bin_attr);
>>> +       if (unlikely(ret)) {
>>
>> Any benifit of (un)likely in probe()?
>
> Does it hurt however in any way though? It's just a compiler optimization
> isn't it.

It hurts readability. probe() function is usually doesn't require
fastest execution. Moreover, [1] tells us "You should use it only in
cases when the likeliest branch is very very very likely, or when the
unlikeliest branch is very very very unlikely."

There also an article [2] about cache issues. Bad usage of the
likely/unlikely macros might lead to performance degradation (cache
misses). You have to think about those macros really carefully.

[1] http://kernelnewbies.org/FAQ/LikelyUnlikely
[2] http://dslab.lzu.edu.cn:8080/docs/publications/NicholasMcGuire.pdf

--
With Best Regards,
Andy Shevchenko
