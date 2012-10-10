From: linus.walleij@linaro.org (Linus Walleij)
Date: Wed, 10 Oct 2012 19:22:04 +0200
Subject: [PATCH 09/11] fsmc/nand:FIX: replace change_bit routine
In-Reply-To: <ec169eb041e87e66c06108e85ea4a67e5797cecc.1349778821.git.vipin.kumar@st.com>
References: <cover.1349778820.git.vipin.kumar@st.com>
 <ec169eb041e87e66c06108e85ea4a67e5797cecc.1349778821.git.vipin.kumar@st.com>
Message-ID: <CACRpkdaot3DKCoJOBpUcJFVrJ89xRx2T58fDe4YKY_r4NFqEag@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Oct 9, 2012 at 12:44 PM, Vipin Kumar <vipin.kumar@st.com> wrote:

> change_bit routine accepts only ulong pointers as buffer, so an unaligned char
> pointer passed to change_bit may lead to a crash.
>
> Fix this bug by accessing the buffer as char pointer.

Why not see if we can fix change_bit() instead?
Since I suspect this is on ARM I bet Russell and Nico
want to hear about this if there is a problem.

Can the ARM change_bit() not be fixed, so that
long arguments are the only option?

>                 if (err_idx[i] < chip->ecc.size * 8) {
> -                       change_bit(err_idx[i], (unsigned long *)dat);
> +                       uint8_t *p = dat + err_idx[i] / 8;
> +                       *p = *p ^ (1 << (err_idx[i] % 8));

I'm one of these people who would write >>3 and
&7 rather than /8 or %8 but I guess we are all
different. Atleast consider it if you stick with this...

Yours,
Linus Walleij
