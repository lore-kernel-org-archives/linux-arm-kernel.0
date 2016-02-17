From: peter@hurleysoftware.com (Peter Hurley)
Date: Tue, 16 Feb 2016 17:31:48 -0800
Subject: [PATCH v2] serial: earlycon: rework common framework for earlycon
 declarations
In-Reply-To: <CAK7LNAS_vietwRRFnH3YhbWSzjRFP4U6rjftYek1KQ3ips2ZSQ@mail.gmail.com>
References: <1455273394-27350-1-git-send-email-yamada.masahiro@socionext.com>
 <56BDF799.1030505@hurleysoftware.com>
 <CAK7LNAS_vietwRRFnH3YhbWSzjRFP4U6rjftYek1KQ3ips2ZSQ@mail.gmail.com>
Message-ID: <56C3CD84.9000504@hurleysoftware.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2016 08:30 AM, Masahiro Yamada wrote:
> Hi Peter,
> 
> 
> 2016-02-13 0:17 GMT+09:00 Peter Hurley <peter@hurleysoftware.com>:
>> On 02/12/2016 02:36 AM, Masahiro Yamada wrote:
>>> Commit 71f50c6d9a22 ("of: drop symbols declared by _OF_DECLARE() from
>>> modules") fixed the link error introduced by commit b8d20e06eaad
>>> ("serial: 8250_uniphier: add earlycon support").
>>>
>>> After commit 2eaa790989e0 ("earlycon: Use common framework for
>>> earlycon declarations") was applied, the link error came back
>>> because the commit reworked OF_EARLYCON_DECLARE() to not use
>>> _OF_DECLARE().
>>
>> What link error are you getting?
> 
> The combination of CONFIG_SERIAL_8250_CONSOLE=y
> and CONFIG_SERIAL_8250_UNIPHIER=m causes a link error.
> 
> 
> 
>>
>>> This commit reworks OF_EARLYCON_DECLARE() again based on
>>> _OF_DECLARE().  My motivations are:
>>>
>>>  - Fix the link error in a generic way (without patching
>>>    drivers/tty/serial/8250/8250_uniphier.c)
>>>
>>>  - Delete struct earlycon_id.  This struct is re-inventing the wheel;
>>>    the fields "name", "compatible", "setup" can be implemented in
>>>    struct of_device_id as other frameworks do.
>>
>> This patch basically reverts the common framework.
>> What happens when not building with OF? Does it still declare the
>> earlycon table?
> 
> Ah, I missed this.  (sigh)
> 
> Earlycon must still work without OF.
> My way only works with OF.
> 
> I really screwed up.  Sorry.

Hi Masahiro,

No big deal.

We need to come up with a better way to enable earlycon builds and
opt-in by driver than the current method. Breaking builds with earlycon
support has happened several times in the last couple of years so
it's not just you.

Regards,
Peter Hurley
