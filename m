From: guy.shapiro@mobi-wize.com (Guy Shapiro)
Date: Wed, 14 Dec 2016 09:09:36 +0200
Subject: [PATCH] Input: imx6ul_tsc - generalize the averaging property
In-Reply-To: <CAL_JsqJAdxrUGL5pjTPDkrXTsKJU-vL1Y4TpqhP79bESs9vR-g@mail.gmail.com>
References: <1481440003-27168-1-git-send-email-guy.shapiro@mobi-wize.com>
 <CAL_JsqJAdxrUGL5pjTPDkrXTsKJU-vL1Y4TpqhP79bESs9vR-g@mail.gmail.com>
Message-ID: <6760ad61-b596-b80d-4100-09f926abab05@mobi-wize.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 13/12/2016 21:54, Rob Herring wrote:

> On Sun, Dec 11, 2016 at 1:06 AM, Guy Shapiro <guy.shapiro@mobi-wize.com> wrote:
>> Make the avarage-samples property a general touchscreen property
>> rather than imx6ul device specific.
>>
>> Signed-off-by: Guy Shapiro <guy.shapiro@mobi-wize.com>
>> ---
>>   .../bindings/input/touchscreen/imx6ul_tsc.txt      | 11 ++----
>>   .../bindings/input/touchscreen/touchscreen.txt     |  3 ++
>>   drivers/input/touchscreen/imx6ul_tsc.c             | 46 ++++++++++++++++------
>>   3 files changed, 41 insertions(+), 19 deletions(-)
> [...]
>
>> +       switch (average_samples) {
>> +       case 1:
>> +               tsc->average_enable = false;
>> +               tsc->average_select = 0; /* value unused; initialize anyway */
>> +               break;
>> +       case 4:
>> +               tsc->average_enable = true;
>> +               tsc->average_select = 0;
>> +               break;
>> +       case 8:
>> +               tsc->average_enable = true;
>> +               tsc->average_select = 1;
>> +               break;
>> +       case 16:
>> +               tsc->average_enable = true;
>> +               tsc->average_select = 2;
>> +               break;
>> +       case 32:
>> +               tsc->average_enable = true;
>> +               tsc->average_select = 3;
>> +               break;
> This could be more efficiently written as
>
> tsc->average_select = log2(average_samples) - 2;
>
> Then enable if >=0.

Using '1' to indicate no averaging is more consistent then using '0'.
I think it is better to validate the values rather then round them.

What do you think about:
+       switch (average_samples) {
+       case 1:
+               tsc->average_enable = false;
+               tsc->average_select = 0; /* value unused; initialize 
anyway */
+               break;
+       case 4:
+       case 8:
+       case 16:
+       case 32:
+               tsc->average_enable = true;
+               tsc->average_select = ilog2(average_samples) - 2;
+               break;
+       default:
+               dev_err(&pdev->dev,
+                       "touchscreen-average-samples (%u) must be 1, 4, 
8, 16 or 32\n",
+                       average_samples);

Guy.
