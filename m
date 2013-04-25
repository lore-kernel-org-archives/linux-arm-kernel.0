From: andy.green@linaro.org (Andy Green)
Date: Fri, 26 Apr 2013 07:51:35 +0800
Subject: [PATCHv3 00/14] drivers: mailbox: framework creation
In-Reply-To: <5179AE2F.3040403@ti.com>
References: <1363145021-14339-1-git-send-email-s-anna@ti.com>
 <CABb+yY0RYkVeo2Sb4WsDJY0jf17488FEz0d2CB994eQaSOEsVg@mail.gmail.com>
 <37C860A02101E749A747FA2D3C1E3C504A5DF7@DLEE11.ent.ti.com>
 <CABb+yY1x4x_A+QtGG9ohsLPgs8c3nEVnd_ExJBGOOR8=6YLPFA@mail.gmail.com>
 <37C860A02101E749A747FA2D3C1E3C504A63B4@DLEE11.ent.ti.com>
 <CAJe_ZhehnniZd730jjiOLrHozq8TOJZgFYLqUe4KqgBiQEu8PA@mail.gmail.com>
 <51779304.4040003@st.com>
 <CAJe_ZhdZv5LW6kdwyPtJe69mfW6t=WQ4OJnG2H4sUhibattN2A@mail.gmail.com>
 <517867E1.7050301@ti.com>
 <CAJe_ZhfDZzq+DzA9XDF3PWFUmwcZnDy-mhE4hLNHmf+V4GhOxw@mail.gmail.com>
 <5179AE2F.3040403@ti.com>
Message-ID: <5179C187.509@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 26/04/13 06:29, the mail apparently from Suman Anna included:

Hi -

>>> 3. Shareable/exclusive nature of a mailbox. If it is shareable, then
>>> duplicating the behavior between clients is not worth it, and this
>>> should be absorbed into the respective controller driver.
>>>
>> I think the mailbox should be exclusively held by a client. That makes
>> many things simpler. Also remote firmwares won't be always robust
>> enough to handle commands from different subsystems intermixed. The
>> API only has to make sure the mailbox_get/put operations are very
>> thin.
>
> This might be the case for specific remotes where we expect only one
> client driver to be responsible for talking to it, but for generic
> offloading, you do not want to have this restriction. You do not want
> peer clients to go through a single main client, as the latencies or the
> infrastructure imposed by the main client may not be suitable for the
> other clients. The stricter usecase here would be the shareable mailbox,
> and if it is exclusive, as dictated by a controller or device property,
> then so be it and things would get simplified for that controller/device.

Knowing why Jassi mentioned this, the situation is a bit different than 
what you replied to.  There are in fact multiple client drivers that can 
asynchronously decide to initiate communication on the same mailbox. 
Some of the client need to perform multi-step sequencing and lock the 
mailbox for the duration.

Right now we can implement that by having a driver on top to mediate, 
Jassi is suggesting being able to do the client locking at your layer as 
a primitive will simplify things, not least get rid of the mediation 
driver.  Your layer has concept of completion and notifier already so it 
seems it wouldn't take much more.

-Andy

-- 
Andy Green | Fujitsu Landing Team Leader
Linaro.org ? Open source software for ARM SoCs | Follow Linaro
http://facebook.com/pages/Linaro/155974581091106  - 
http://twitter.com/#!/linaroorg - http://linaro.org/linaro-blog
