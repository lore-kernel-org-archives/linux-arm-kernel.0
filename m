From: patrice.chotard@st.com (Patrice CHOTARD)
Date: Wed, 7 Mar 2018 08:01:11 +0000
Subject: [PATCH v2 3/3] tty: st-asc: Update tty alias
In-Reply-To: <CAL_JsqJv-FV4T8=+py2EEr4kipnQikJPhDKkDdvkAab2QTgBzg@mail.gmail.com>
References: <1520323650-11030-1-git-send-email-patrice.chotard@st.com>
 <1520323650-11030-4-git-send-email-patrice.chotard@st.com>
 <CAL_JsqJv-FV4T8=+py2EEr4kipnQikJPhDKkDdvkAab2QTgBzg@mail.gmail.com>
Message-ID: <394e92bd-3e6c-6163-4a9f-66182e41238b@st.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Rob

On 03/06/2018 02:29 PM, Rob Herring wrote:
> On Tue, Mar 6, 2018 at 2:07 AM,  <patrice.chotard@st.com> wrote:
>> From: Patrice Chotard <patrice.chotard@st.com>
>>
>> Since dtc v1.4.6-9-gaadd0b65c987, aliases property name
>> must include only lowercase and '-'.
>>
>> After having updated all STi boards serial aliases from "ttyASN"
>> to "serialN", st-asc driver need to be updated accordingly as tty
>> aliases id is retrieved using of_alias_get_id(np, ASC_SERIAL_NAME);
> 
> Again, changing the tty name breaks userspace. You can't do that.
> 
> You need to do something like this:
> 
> diff --git a/drivers/tty/serial/st-asc.c b/drivers/tty/serial/st-asc.c
> index c763253514e9..5f9f01fac6dd 100644
> --- a/drivers/tty/serial/st-asc.c
> +++ b/drivers/tty/serial/st-asc.c
> @@ -782,7 +782,9 @@ static struct asc_port *asc_of_get_asc_port(struct
> platform_device *pdev)
>          if (!np)
>                  return NULL;
> 
> -       id = of_alias_get_id(np, ASC_SERIAL_NAME);
> +       id = of_alias_get_id(np, "serial");
> +       if (id < 0)
> +               id = of_alias_get_id(np, ASC_SERIAL_NAME);
> 
>          if (id < 0)
>                  id = 0;
> 
I will fix this too

Patrice
