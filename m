From: arnd@arndb.de (Arnd Bergmann)
Date: Mon, 30 Dec 2013 21:27:41 +0100
Subject: [PATCH 2/3] mmc: dw_mmc: add dw_mmc-k3 for k3 platform
In-Reply-To: <52C1AB34.3010402@linaro.org>
References: <1388241295-20051-1-git-send-email-zhangfei.gao@linaro.org>
 <CAMj5Bkif9pQHVdA71QccamVQkfgTheUNzowW6AyTwC3dy5XF+g@mail.gmail.com>
 <52C1AB34.3010402@linaro.org>
Message-ID: <201312302127.41690.arnd@arndb.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Monday 30 December 2013, zhangfei wrote:
> >>>> +static int dw_mci_k3_suspend(struct device *dev)
> >>>> +{
> >>>> +    struct dw_mci *host = dev_get_drvdata(dev);
> >>>> +    int ret = 0;
> >>>> +
> >>>> +    ret = dw_mci_suspend(host);
> >>>
> >>> You should never initialize local variables when they are set later in the
> >>> function (the ret = 0 part above). For more complex functions, this prevents
> >>> gcc from warning you about accidentally uninitialized uses.
> 
> I am sorry I may fall into the dead end, but still quite not understand 
> this rule.
> I alwayes thought it would be a good habit to init local variables before.
> Do you mean it should NOT init local variable as much as possible and 
> only init on demand, like solving the gcc warning.
> Why not init the them at start in case random value cause unpredicted error?

The gcc warnings are 100% correct, we can use them as a tool to write better
code. If you write code that has no warnings with a modern compiler, you will
never use random values, but if you always initialize the local variables,
you can end up accidentally using '0' where you shouldn't have.

See http://rusty.ozlabs.org/?p=232 for an excellent article on the topic
by former Linaro assignee Rusty Russell.

	Arnd
