From: jaswinder.singh@linaro.org (Jassi Brar)
Date: Sat, 8 Nov 2014 23:51:35 +0530
Subject: [PATCH 2/2] mailbox: Don't unnecessarily re-arm the polling timer
In-Reply-To: <20141031114107.GE10778@ulmo.nvidia.com>
References: <1414699267-17970-1-git-send-email-abrestic@chromium.org>
 <1414699267-17970-2-git-send-email-abrestic@chromium.org>
 <20141031114107.GE10778@ulmo.nvidia.com>
Message-ID: <CAJe_ZhcC-nEUQSxVy3AUkAvWrM74TeafX1umqVuWxBSQ=zVdqg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 31 October 2014 17:11, Thierry Reding <thierry.reding@gmail.com> wrote:
> On Thu, Oct 30, 2014 at 01:01:07PM -0700, Andrew Bresticker wrote:
>> poll_txdone() will unconditionally re-arm the polling timer if there was
>> an active request, even if the active request completed and no other
>> requests were submitted.  This is fixed by:
>>  - only re-arming the timer if the controller reported that the current
>>    transmission has not completed, and,
>>  - moving the call to poll_txdone() into msg_submit() so that the
>>    controller gets polled (and the timer re-armed, if necessary) whenever
>>    a new message is submitted.
>>
>> Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
>> ---
>>  drivers/mailbox/mailbox.c | 13 ++++++++-----
>>  1 file changed, 8 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/mailbox/mailbox.c b/drivers/mailbox/mailbox.c
>> index 5008028..26f74ad 100644
>> --- a/drivers/mailbox/mailbox.c
>> +++ b/drivers/mailbox/mailbox.c
>> @@ -28,6 +28,8 @@
>>  static LIST_HEAD(mbox_cons);
>>  static DEFINE_MUTEX(con_mutex);
>>
>> +static void poll_txdone(unsigned long data);
>
> I think I'd rather move poll_txdone() here to avoid the forward
> declaration, but either way:
>
> Reviewed-by: Thierry Reding <treding@nvidia.com>
>
Does the 'extra' timer fire cause some issue? I believe it shouldn't.
Anyways, I have applied the patch.

Thanks
Jassi
