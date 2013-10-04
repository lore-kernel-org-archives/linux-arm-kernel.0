From: alexei.starovoitov@gmail.com (Alexei Starovoitov)
Date: Thu, 3 Oct 2013 23:30:41 -0700
Subject: [PATCH v3 net-next] fix unsafe set_memory_rw from softirq
In-Reply-To: <1380863798.3564.12.camel@edumazet-glaptop.roam.corp.google.com>
References: <1380859875-31025-1-git-send-email-ast@plumgrid.com>
 <1380863798.3564.12.camel@edumazet-glaptop.roam.corp.google.com>
Message-ID: <CAADnVQJq7r-e=vQBcvMqxEkFVzMjn=EaZ99j2boPj+YJBAhKxw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Oct 3, 2013 at 10:16 PM, Eric Dumazet <eric.dumazet@gmail.com> wrote:
> On Thu, 2013-10-03 at 21:11 -0700, Alexei Starovoitov wrote:
>
> -static inline unsigned int sk_filter_len(const struct sk_filter *fp)
> +static inline unsigned int sk_filter_size(const struct sk_filter *fp,
> +                                         unsigned int proglen)
>  {
> -       return fp->len * sizeof(struct sock_filter) + sizeof(*fp);
> +       return max(sizeof(*fp),
> +                  offsetof(struct sk_filter, insns[proglen]));
>  }

indeed that's cleaner.
Like this then:
-static inline unsigned int sk_filter_len(const struct sk_filter *fp)
+static inline unsigned int sk_filter_size(unsigned int proglen)
 {
-       return fp->len * sizeof(struct sock_filter) + sizeof(*fp);
+       return max(sizeof(struct sk_filter),
+                  offsetof(struct sk_filter, insns[proglen]));
 }

testing it... will send v4 shortly
